package au.edu.utas.tkrimmer.assignment2kit305

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import au.edu.utas.tkrimmer.assignment2kit305.databinding.ActivityHistoryBinding
import au.edu.utas.tkrimmer.assignment2kit305.databinding.MyListItemBinding
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.firestore.ktx.toObject
import com.google.firebase.ktx.Firebase
const val FIREBASE_TAG = "FirebaseLogging"
const val MOVIE_INDEX = "Movie_Index"

val items = mutableListOf<Movie>()

class History : AppCompatActivity() {

    private lateinit var ui: ActivityHistoryBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ui = ActivityHistoryBinding.inflate(layoutInflater)
        setContentView(ui.root)

        ui.lblMovieCount.text = "${items.size} Movies"
        ui.myList.adapter = MovieAdapter(movies = items)

        //vertical list
        ui.myList.layoutManager = LinearLayoutManager(this)
        val db = Firebase.firestore
//add some data (comment this out after running the program once and confirming your data is there)
//        val lotr = Movie(
//            session = 1,
//            gameStartTime = "2022-04-28T10:51:42:150",
//            gameEndTime = "2022-04-28T10:51:42:150"
//
//
//        )
          var moviesCollection = db.collection("movies")
//        moviesCollection
//            .add(lotr)
//            .addOnSuccessListener {
//                Log.d(FIREBASE_TAG, "Document created with id ${it.id}")
//                lotr.id = it.id
//            }
//            .addOnFailureListener {
//                Log.e(FIREBASE_TAG, "Error writing document", it)
//            }
        //get all movies
        ui.lblMovieCount.text = "Loading..."
        moviesCollection
            .get()
            .addOnSuccessListener { result ->
                items.clear() //this line clears the list, and prevents a bug where items would be duplicated upon rotation of screen
                Log.d(FIREBASE_TAG, "--- all movies ---")
                for (document in result) {
                    //Log.d(FIREBASE_TAG, document.toString())
                    val movie = document.toObject<Movie>()
                    movie.id = document.id
                    Log.d(FIREBASE_TAG, movie.toString())

                    items.add(movie)
                }
                (ui.myList.adapter as MovieAdapter).notifyDataSetChanged()
            }


    }

    inner class MovieHolder(var ui: MyListItemBinding) : RecyclerView.ViewHolder(ui.root) {}

    inner class MovieAdapter(private val movies: MutableList<Movie>) :
        RecyclerView.Adapter<MovieHolder>() {
        override fun onCreateViewHolder(
            parent: ViewGroup,
            viewType: Int
        ): History.MovieHolder {
            val ui = MyListItemBinding.inflate(
                layoutInflater,
                parent,
                false
            )   //inflate a new row from the my_list_item.xml
            return MovieHolder(ui)                                                            //wrap it in a ViewHolder
        }

        override fun getItemCount(): Int {
            return movies.size
        }

        override fun onBindViewHolder(holder: History.MovieHolder, position: Int) {
            val movie = movies[position]   //get the data at the requested position
            holder.ui.txtName.text = "Session ID: ${movie.title}"
            holder.ui.txtYear.text = "Score: ${movie.session.toString()}"
            holder.ui.txtEndTime.text = "Start Time: ${movie.gameEndTime.toString()}"
            holder.ui.txtStartTime.text = "End Time: ${movie.gameStartTime.toString()}"

            ui.lblMovieCount.text = itemCount.toString()

        }
    }
    override fun onResume() {
        super.onResume()

        ui.myList.adapter?.notifyDataSetChanged()
    }
}

