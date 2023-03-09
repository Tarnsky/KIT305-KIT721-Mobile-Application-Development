package au.edu.utas.tkrimmer.assignment2kit305

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

class GameEnd : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_game_end)
        val db = Firebase.firestore
        //add some data (comment this out after running the program once and confirming your data is there)
            val lotr = Movie(
                session = findViewById(R.id.textViewScore),
                gameStartTime = findViewById(R.id.textViewStart),
                gameEndTime = findViewById(R.id.textViewEnd)
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
    }
}