/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.ncirl;

/**
 *
 * @author sean
 */
import java.lang.reflect.Method;
import java.io.*;
import org.tartarus.snowball.ext.*;
import org.tartarus.snowball.*;

public class Stemmer {

    public static SStack StemText(String str) {

        SnowballStemmer stemmer = new englishStemmer();
        str = str + " ";//required to capture last word
        InputStream reader = new ByteArrayInputStream(str.getBytes());
        StringBuffer input = new StringBuffer();
        String current = new String();
        SStack stk = new SStack(); //return stemed words in a stack
        int character;
        try {
            while ((character = reader.read()) != -1) {
                char ch = (char) character;
                if (Character.isWhitespace((char) ch)) {
                    if (input.length() > 0) {
                        stemmer.setCurrent(input.toString());
                        
                        stemmer.stem();
                        current = stemmer.getCurrent();
                        stk.push(current);
                      
                        input.delete(0, input.length());
                    }
                } else {
                    input.append(Character.toLowerCase(ch));
                }
            }

        } catch (IOException e) {
            System.out.println("error reading ");
        }
        return stk;
    }
}
