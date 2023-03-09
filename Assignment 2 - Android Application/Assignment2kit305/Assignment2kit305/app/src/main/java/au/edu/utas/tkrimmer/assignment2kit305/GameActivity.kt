package au.edu.utas.tkrimmer.assignment2kit305

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.content.ClipData
import android.content.ClipDescription
import android.graphics.Canvas
import android.graphics.Point
import android.os.Build
import android.view.DragEvent
import android.view.View
import android.widget.Toast
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.content.res.ResourcesCompat
import au.edu.utas.tkrimmer.assignment2kit305.databinding.ActivityGameBinding
//https://www.raywenderlich.com/24508555-android-drag-and-drop-tutorial-moving-views-and-data

class GameActivity : AppCompatActivity() {

    private lateinit var binding : ActivityGameBinding

    private val tailDragMessage = "Tail added"
    private val tailOn = "Nice"
    private val tailOff = "Tail off"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_game)

        binding = ActivityGameBinding.inflate(layoutInflater)
        setContentView(binding.root)

        attachViewDragListener()

        binding.tailDropArea.setOnDragListener(tailDragListener)

    }

    // Creates a tail drag event listener
    private val tailDragListener = View.OnDragListener { view, dragEvent ->

        val draggableItem = dragEvent.localState as View

        when (dragEvent.action) {
            DragEvent.ACTION_DRAG_STARTED -> {
                true
            }
            DragEvent.ACTION_DRAG_ENTERED -> {
                // dims the view when the tail has entered the drop area
                binding.tailDropArea.alpha = 0.3f
                true
            }
            DragEvent.ACTION_DRAG_LOCATION -> {
                true
            }
            DragEvent.ACTION_DRAG_EXITED -> {
                // reset opacity if the tail exits drop area without drop action
                binding.tailDropArea.alpha = 1.0f
                //when tail exits drop-area without dropping set tail visibility to VISIBLE
                draggableItem.visibility = View.VISIBLE
                view.invalidate()
                true
            }
            DragEvent.ACTION_DROP -> {
                // reset opacity if the tail is dropped
                binding.tailDropArea.alpha = 1.0f

                //on drop event in the target drop area, read the data and
                // re-position the tail in it's new location
                if (dragEvent.clipDescription.hasMimeType(ClipDescription.MIMETYPE_TEXT_PLAIN)) {
                    val draggedData = dragEvent.clipData.getItemAt(0).text
                    println("draggedData $draggedData")
                }

                //re-position the tail in the updated x, y co-ordinates
                // with tail center position pointing to new x,y co-ordinates
                draggableItem.x = dragEvent.x - (draggableItem.width / 2)
                draggableItem.y = dragEvent.y - (draggableItem.height / 2)

                //on drop event remove the tail from parent viewGroup
                val parent = draggableItem.parent as ConstraintLayout
                parent.removeView(draggableItem)

                //add the tail view to a new viewGroup where the tail was dropped
                val dropArea = view as ConstraintLayout
                dropArea.addView(draggableItem)

                checkIfTailIsOnDonkey(dragEvent)
                true
            }
            DragEvent.ACTION_DRAG_ENDED -> {
                draggableItem.visibility = View.VISIBLE
                view.invalidate()
                true
            }
            else -> {
                false
            }

        }
    }

    /**
     * Method checks whether the tail is dropped on the donkey and
     * displays an appropriate Toast message
     *
     * @param dragEvent DragEvent
     */
    private fun checkIfTailIsOnDonkey(dragEvent: DragEvent) {
        //x,y co-ordinates left-top point
        val donkeyXStart = binding.tailDropArea.x
        val donkeyYStart = binding.tailDropArea.y

        //x,y co-ordinates bottom-end point
        val donkeyXEnd = donkeyXStart + binding.tailDropArea.width
        val donkeyYEnd = donkeyYStart + binding.tailDropArea.height

        val toastMsg = if (dragEvent.x in donkeyXStart..donkeyXEnd && dragEvent.y in donkeyYStart..donkeyYEnd){
            tailOn
        } else {
            tailOff
        }

        Toast.makeText(this, toastMsg, Toast.LENGTH_SHORT).show()

    }

    /**
     * Method enables drag feature on the draggable view
     */
    private fun attachViewDragListener() {

        binding.tail.setOnLongClickListener { view: View ->

            // Create a new ClipData.Item with custom text data
            val item = ClipData.Item(tailDragMessage)

            // Create a new ClipData using a predefined label, the plain text MIME type, and
            // the already-created item. This will create a new ClipDescription object within the
            // ClipData, and set its MIME type entry to "text/plain"
            val dataToDrag = ClipData(
                tailDragMessage,
                arrayOf(ClipDescription.MIMETYPE_TEXT_PLAIN),
                item
            )

            // Instantiates the drag shadow builder.
            val tailShadow = TailDragShadowBuilder(view)

            // Starts the drag
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N) {
                //support pre-Nougat versions
                @Suppress("DEPRECATION")
                view.startDrag(dataToDrag, tailShadow, view, 0)
            } else {
                //supports Nougat and beyond
                view.startDragAndDrop(dataToDrag, tailShadow, view, 0)
            }

            view.visibility = View.INVISIBLE
            true
        }

    }
}

/**
 * Drag shadow builder builds a shadow for the tail when drag is ongoing
 *
 * @param view View for which drag shadow has to be displayed
 */
private class TailDragShadowBuilder(view: View) : View.DragShadowBuilder(view) {

    //set shadow to be the actual tail
    private val shadow = ResourcesCompat.getDrawable(view.context.resources, R.drawable.donkey, view.context.theme)

    // Defines a callback that sends the drag shadow dimensions and touch point back to the
    // system.
    override fun onProvideShadowMetrics(size: Point, touch: Point) {
        // Sets the width of the shadow to full width of the original View
        val width: Int = view.width

        // Sets the height of the shadow to full height of the original View
        val height: Int = view.height

        // The drag shadow is a Drawable. This sets its dimensions to be the same as the
        // Canvas that the system will provide. As a result, the drag shadow will fill the
        // Canvas.
        shadow?.setBounds(0, 0, width, height)

        // Sets the size parameter's width and height values. These get back to the system
        // through the size parameter.
        size.set(width, height)

        // Sets the touch point's position to be in the middle of the drag shadow
        touch.set(width / 2, height / 2)
    }

    // Defines a callback that draws the drag shadow in a Canvas that the system constructs
    // from the dimensions passed in onProvideShadowMetrics().
    override fun onDrawShadow(canvas: Canvas) {
        // Draws the Drawable in the Canvas passed in from the system.
        shadow?.draw(canvas)
    }
}
