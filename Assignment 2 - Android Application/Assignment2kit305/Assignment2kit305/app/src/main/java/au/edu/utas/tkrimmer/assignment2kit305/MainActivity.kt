package au.edu.utas.tkrimmer.assignment2kit305

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import au.edu.utas.tkrimmer.assignment2kit305.databinding.ActivityMainBinding
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.firestore.ktx.toObject
import com.google.firebase.ktx.Firebase


var userName = "Sherk"

class MainActivity : AppCompatActivity() {

    private lateinit var ui : ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        ui = ActivityMainBinding.inflate(layoutInflater)
        setContentView(ui.root)

        ui.textViewName.text = "Hello $userName"
        ui.Play.setOnClickListener {
            var intent = Intent(this, GameSetUp::class.java)
            startActivity(intent)
        }
        ui.History.setOnClickListener {
            var intent = Intent(this, History::class.java)
            startActivity(intent)
        }

    }
    fun buttonName(view: View){
        userName = "donkey?"
        ui.textViewName.text = "Hello $userName"

    }
}