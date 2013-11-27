/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.ncirl.exceptions;

/**
 *
 * @author sean
 **/
public class MissingParameterException extends Exception {

    String mistake;

//----------------------------------------------
// Default constructor - initializes instance variable to unknown
    public MissingParameterException() {
        super();             // call superclass constructor
        mistake = "unknown";
    }

//-----------------------------------------------
// Constructor receives some kind of message that is saved in an instance variable.
    public MissingParameterException(String err) {
        super(err);     // call super class constructor
        mistake = err;  // save message
    }

//------------------------------------------------
// public method, callable by exception catcher. It returns the error message.
    public String getError() {
        return mistake;
    }
}

