package au.edu.utas.tkrimmer.assignment2kit305

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import au.edu.utas.tkrimmer.assignment2kit305.databinding.ActivityGameSetUpBinding

class GameSetUp : AppCompatActivity() {

    private lateinit var ui : ActivityGameSetUpBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        ui = ActivityGameSetUpBinding.inflate(layoutInflater)
        setContentView(ui.root)

        ui.Play.setOnClickListener {
            var intent = Intent(this, GameMain::class.java)
            startActivity(intent)
        }
        ui.Freeplay.setOnClickListener {
            var intent = Intent(this, GameActivity::class.java)
            startActivity(intent)
        }
        ui.PinGame.setOnClickListener {
            var intent = Intent(this, GameActivity::class.java)
            startActivity(intent)
        }
    }
}