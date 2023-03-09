package au.edu.utas.tkrimmer.assignment2kit305

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import au.edu.utas.tkrimmer.assignment2kit305.databinding.ActivityMovieDetailsBinding
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

class MovieDetails : AppCompatActivity() {
    private lateinit var ui : ActivityMovieDetailsBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ui = ActivityMovieDetailsBinding.inflate(layoutInflater)
        setContentView(ui.root)
//get movie object using id from intent
        val movieID = intent.getIntExtra(MOVIE_INDEX, -1)
        var movieObject = items[movieID]
//TODO: you'll need to set txtTitle, txtYear, txtDuration yourself
        val db = Firebase.firestore
        var moviesCollection = db.collection("movies")

        ui.btnSave.setOnClickListener {
            //get the user input
            movieObject.title = ui.txtTitle.text.toString()

            //update the database
            moviesCollection.document(movieObject.id!!)
                .set(movieObject)
                .addOnSuccessListener {
                    Log.d(FIREBASE_TAG, "Successfully updated movie ${movieObject?.id}")
                    //return to the list
                    finish()
                }
        }
    }
}