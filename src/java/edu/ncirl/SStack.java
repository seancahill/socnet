/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.ncirl;

import java.util.Stack;

/**
 *
 * @author sean
 */
public class SStack extends Stack {

    @Override
    public String toString() {
        //method to change a stack of words into a string of words
        //separated by white space
        StringBuilder s = new StringBuilder();
        for (Object item : this) {
            s.append((String) item);
            s.append(" ");
        }
        return s.toString().trim();
    }

    public String toStoreString() {
        //method to change a stack of words into a string of words
        //separated by white space
        StringBuilder s = new StringBuilder();
        int j = this.size();
        int i = 0;
        for (Object item : this) {
            i = i + 1;
            s.append((String) item);
            if (i < j) {
                s.append(",");
            }
        }
        return s.toString();
    }
    public SStack toLower() {
        //method to change a stack of words into a string of words
        //separated by white space
        SStack s = new SStack();
        for (Object item : this) {
            String lword = item.toString();
            s.add(lword.toLowerCase().trim());
        }
        return s;
    }
}
