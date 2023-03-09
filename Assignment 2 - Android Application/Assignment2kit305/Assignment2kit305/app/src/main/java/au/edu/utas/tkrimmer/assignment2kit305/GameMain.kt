package au.edu.utas.tkrimmer.assignment2kit305

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.EditText
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import au.edu.utas.tkrimmer.assignment2kit305.databinding.ActivityGameMainBinding
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import java.time.LocalDateTime
import java.util.Collections.list
import kotlin.random.Random

var score = 0
var tracker = 1
var myRandomInt = (1..3).shuffled()
var bRandomInt = myRandomInt[0]
var aRandomInt = myRandomInt[1]
var cRandomInt = myRandomInt[2]
var startTime: LocalDateTime? = null
var endTime : LocalDateTime? = null
class GameMain : AppCompatActivity() {

    private lateinit var ui : ActivityGameMainBinding


    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ui = ActivityGameMainBinding.inflate(layoutInflater)
        setContentView(ui.root)
        startTime = LocalDateTime.now()
        ui.textViewScore.text = "Push Button $tracker, Score $score"
        ui.buttonB.text = "$bRandomInt"
        ui.buttonA.text = "$aRandomInt"
        ui.buttonC.text = "$cRandomInt"
        ui.textViewStart.text = "Start Time: $startTime"
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun buttonAcheck(view: View) {
        if (aRandomInt == tracker) {
            tracker++
            ui.textViewScore.text = "Push Button $tracker, Score $score"
            if (tracker == 4) {
                tracker = 1
                myRandomInt = (1..3).shuffled()
                bRandomInt = myRandomInt[0]
                aRandomInt = myRandomInt[1]
                cRandomInt = myRandomInt[2]
                ui.buttonB.text = "$bRandomInt"
                ui.buttonA.text = "$aRandomInt"
                ui.buttonC.text = "$cRandomInt"
                score++
                if (score == 3) {
                    ui.textViewScore.text = "Score: $score Game Over!"
                    endTime = LocalDateTime.now()
                    ui.textViewEnd.text = "End Time: $endTime"
                    ui.buttonA.isEnabled = false
                    ui.buttonA.isClickable = false
                    ui.buttonB.isEnabled = false
                    ui.buttonB.isClickable = false
                    ui.buttonC.isEnabled = false
                    ui.buttonC.isClickable = false
                }
                else {
                    ui.textViewScore.text = "Push Button $tracker, Score $score"
                }
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun buttonBcheck(view: View) {
        if (bRandomInt == tracker) {
            tracker++
            ui.textViewScore.text = "Push Button $tracker, Score $score"
            if (tracker == 4) {
                tracker = 1
                myRandomInt = (1..3).shuffled()
                bRandomInt = myRandomInt[0]
                aRandomInt = myRandomInt[1]
                cRandomInt = myRandomInt[2]
                ui.buttonB.text = "$bRandomInt"
                ui.buttonA.text = "$aRandomInt"
                ui.buttonC.text = "$cRandomInt"
                score++
                if (score == 3) {
                    ui.textViewScore.text = "Score: $score Game Over!"
                    endTime = LocalDateTime.now()
                    ui.textViewEnd.text = "End Time: $endTime"
                    ui.buttonA.isEnabled = false
                    ui.buttonA.isClickable = false
                    ui.buttonB.isEnabled = false
                    ui.buttonB.isClickable = false
                    ui.buttonC.isEnabled = false
                    ui.buttonC.isClickable = false

                }
                else {
                    ui.textViewScore.text = "Push Button $tracker, Score $score"
                }            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun buttonCcheck(view: View) {
        if (cRandomInt == tracker) {
            tracker++
            ui.textViewScore.text = "Push Button $tracker, Score $score"
            if (tracker == 4){
                tracker = 1
                myRandomInt = (1..3).shuffled()
                bRandomInt = myRandomInt[0]
                aRandomInt = myRandomInt[1]
                cRandomInt = myRandomInt[2]
                ui.buttonB.text = "$bRandomInt"
                ui.buttonA.text = "$aRandomInt"
                ui.buttonC.text = "$cRandomInt"
                score++
                if (score == 3) {
                    ui.textViewScore.text = "Score: $score Game Over!"
                    endTime = LocalDateTime.now()
                    ui.textViewEnd.text = "End Time: $endTime"
                    ui.buttonA.isEnabled = false
                    ui.buttonA.isClickable = false
                    ui.buttonB.isEnabled = false
                    ui.buttonB.isClickable = false
                    ui.buttonC.isEnabled = false
                    ui.buttonC.isClickable = false

                }
                else {
                    ui.textViewScore.text = "Push Button $tracker, Score $score"
                }            }
        }
    }

    fun buttonEndGame(view: View) {

        val db = Firebase.firestore
        //add some data (comment this out after running the program once and confirming your data is there)
        val lotr = Movie(
            session = score,
            gameStartTime = startTime.toString(),
            gameEndTime = endTime.toString()
        )
        var moviesCollection = db.collection("movies")
        moviesCollection
            .add(lotr)
            .addOnSuccessListener {
                Log.d(FIREBASE_TAG, "Document created with id ${it.id}")
                lotr.id = it.id
            }
            .addOnFailureListener {
                Log.e(FIREBASE_TAG, "Error writing document", it)
            }
        score = 0
        var intent = Intent(this, MainActivity::class.java)
        startActivity(intent)
    }
}