import asl.utils.ObjectUtilites;
import asl.utils.ClassUtilites;
import asl.core.IllegalStateException;
import asl.core.IllegalArgumentException;

class asl.core.Throwable implements asl.core.ISerializable {
    /**
     * Specific details about the Throwable.
     *
     * @serial
     */
    private var _detailMessage : String;

    /**
     * The throwable that caused this throwable to get thrown, or null if this
     * throwable was not caused by another throwable, or if the causative
     * throwable is unknown.  If this field is equal to this throwable itself,
     * it indicates that the cause of this throwable has not yet been
     * initialized.
     *
     * @serial
     */
    private var _cause : Throwable;

    /**
     * Constructs a new throwable with <code>null</code> as its detail message.
     * The cause is not initialized, and may subsequently be initialized by a
     * call to {@link #initCause}.
     */
    public function Throwable() {
		_cause = this;
		
		if (arguments.length == 1) {
			if (ObjectUtilites.isString(arguments[0])) {
				_detailMessage = arguments[0];
			} else if (arguments[0] instanceof Throwable) {
				_cause = arguments[0];
				_detailMessage = (_cause == null ? null : _cause.toString());
			}
		} else if (arguments.length == 2) {
			_detailMessage = arguments[0];
			_cause = arguments[1];
		}
    }

    /**
     * Returns the detail message string of this throwable.
     *
     * @return  the detail message string of this <tt>Throwable</tt> instance
     *          (which may be <tt>null</tt>).
     */
    public function get message() : String {
        return _detailMessage;
    }

    /**
     * Creates a localized description of this throwable.
     * Subclasses may override this method in order to produce a
     * locale-specific message.  For subclasses that do not override this
     * method, the default implementation returns the same result as
     * <code>getMessage()</code>.
     *
     * @return  The localized description of this throwable.
     */
    public function get localizedMessage() : String {
        return message;
    }

    /**
     * Returns the cause of this throwable or <code>null</code> if the
     * cause is nonexistent or unknown.  (The cause is the throwable that
     * caused this throwable to get thrown.)
     *
     * <p>This implementation returns the cause that was supplied via one of
     * the constructors requiring a <tt>Throwable</tt>, or that was set after
     * creation with the {@link #initCause(Throwable)} method.  While it is
     * typically unnecessary to override this method, a subclass can override
     * it to return a cause set by some other means.  This is appropriate for
     * a "legacy chained throwable" that predates the addition of chained
     * exceptions to <tt>Throwable</tt>.  Note that it is <i>not</i>
     * necessary to override any of the <tt>PrintStackTrace</tt> methods,
     * all of which invoke the <tt>getCause</tt> method to determine the
     * cause of a throwable.
     *
     * @return  the cause of this throwable or <code>null</code> if the
     *          cause is nonexistent or unknown.
     */
    public function get cause() : Throwable {
        return (_cause==this ? null : _cause);
    }

    /**
     * Initializes the <i>cause</i> of this throwable to the specified value.
     * (The cause is the throwable that caused this throwable to get thrown.) 
     *
     * <p>This method can be called at most once.  It is generally called from 
     * within the constructor, or immediately after creating the
     * throwable.  If this throwable was created
     * with {@link #Throwable(Throwable)} or
     * {@link #Throwable(String,Throwable)}, this method cannot be called
     * even once.
     *
     * @param  cause the cause (which is saved for later retrieval by the
     *         {@link #getCause()} method).  (A <tt>null</tt> value is
     *         permitted, and indicates that the cause is nonexistent or
     *         unknown.)
     * @return  a reference to this <code>Throwable</code> instance.
     * @throws IllegalArgumentException if <code>cause</code> is this
     *         throwable.  (A throwable cannot be its own cause.)
     * @throws IllegalStateException if this throwable was
     *         created with {@link #Throwable(Throwable)} or
     *         {@link #Throwable(String,Throwable)}, or this method has already
     *         been called on this throwable.
     * @since  1.4
     */
    public function initCause(cause : Throwable) : Throwable {
        if (_cause != this) {
            throw new IllegalStateException("Can't overwrite cause");
		}
        if (cause == this) {
            throw new IllegalArgumentException("Self-causation not permitted");
		}
        _cause = cause;
        return this;
    }

    /**
     * Returns a short description of this throwable.
     * If this <code>Throwable</code> object was created with a non-null detail
     * message string, then the result is the concatenation of three strings: 
     * <ul>
     * <li>The name of the actual class of this object 
     * <li>": " (a colon and a space)
     * <li>The result of the {@link #getMessage} method for this object 
     * </ul>
     * If this <code>Throwable</code> object was created with a <tt>null</tt>
     * detail message string, then the name of the actual class of this object
     * is returned. 
     *
     * @return a string representation of this throwable.
     */
    public function toString() : String {
        var s : String = ClassUtilites.getPath(ObjectUtilites.getClass(this));;
        var message : String = localizedMessage;
        return (message != null) ? (s + ": " + message) : s;
    }
}