package org.graphite.wallettest

import android.app.Activity
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.drawable.Icon
import android.nfc.cardemulation.HostApduService
import android.os.Bundle
import android.service.quickaccesswallet.GetWalletCardsCallback
import android.service.quickaccesswallet.GetWalletCardsRequest
import android.service.quickaccesswallet.GetWalletCardsResponse
import android.service.quickaccesswallet.QuickAccessWalletService
import android.service.quickaccesswallet.SelectWalletCardRequest
import android.service.quickaccesswallet.WalletCard
import android.view.WindowManager
import android.widget.Toast

private val CARDS = listOf(
    Triple("test-1", "Test Debit  0000", Color.rgb(32, 92, 168)),
    Triple("test-2", "Test Credit 1111", Color.rgb(150, 40, 60)),
    Triple("test-3", "Test Travel 2222", Color.rgb(30, 120, 80)),
)

/** Three cards that don't exist and can't pay for anything. */
class TestCardsService : QuickAccessWalletService() {
    override fun onWalletCardsRequested(request: GetWalletCardsRequest, callback: GetWalletCardsCallback) {
        val width = request.cardWidthPx
        val height = request.cardHeightPx
        val cards = CARDS.take(request.maxCards).mapIndexed { index, (id, label, color) ->
            val open = PendingIntent.getActivity(
                this, index,
                Intent(this, OpenActivity::class.java).putExtra("card", label),
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
            )
            WalletCard.Builder(id, Icon.createWithBitmap(draw(width, height, label, color)), label, open)
                .setCardLabel(label)
                .build()
        }
        callback.onSuccess(GetWalletCardsResponse(cards, 0))
    }

    override fun onWalletCardSelected(request: SelectWalletCardRequest) {}
    override fun onWalletDismissed() {}

    private fun draw(width: Int, height: Int, label: String, color: Int): Bitmap {
        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        canvas.drawColor(color)
        val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            this.color = Color.WHITE
            textSize = height * 0.12f
        }
        canvas.drawText(label, width * 0.08f, height * 0.85f, paint)
        // The wallet API only accepts hardware bitmaps
        return bitmap.copy(Bitmap.Config.HARDWARE, false)
    }
}

/** A bright FLAG_SECURE screen, to see whether a capture includes it or shows black. */
class SecureActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
        // Something to see in the status bar, for testing the notification icon switch
        val manager = getSystemService(NotificationManager::class.java)
        manager.createNotificationChannel(NotificationChannel("test", "Test", NotificationManager.IMPORTANCE_DEFAULT))
        manager.notify(1, Notification.Builder(this, "test").setSmallIcon(android.R.drawable.ic_menu_agenda)
            .setContentTitle("Wallet Test Cards").build())
        window.decorView.setBackgroundColor(Color.rgb(230, 40, 120))
    }
}

class OpenActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Toast.makeText(this, intent.getStringExtra("card") ?: "Wallet Test Cards", Toast.LENGTH_LONG).show()
        finish()
    }
}

/** Only here because the wallet role expects a payment service. Refuses everything. */
class TestPaymentService : HostApduService() {
    override fun processCommandApdu(commandApdu: ByteArray, extras: Bundle?): ByteArray = byteArrayOf(0x6A, 0x82.toByte())
    override fun onDeactivated(reason: Int) {}
}
