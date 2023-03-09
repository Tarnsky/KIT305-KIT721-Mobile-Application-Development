package au.edu.utas.tkrimmer.assignment2kit305

import kotlin.random.Random

class Movie (
    var id : String? = null,

    var title : String? = Random.nextInt(1, 10000).toString(),
    var session : Int? = null,
    var gameStartTime : String? = null,
    var gameEndTime : String? = null
)