/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.ncirl;

/**
 *
 * @author sean
 */
import com.eaio.stringsearch.*;
/**
 *
 * @author gandhi
 */
public class PatternMatcher {

    public static SStack runPatternMatch(String stemmed, String compare, StringSearch pm)
    {
        String[] stemmedList = stemmed.trim().split(",");
        SStack matched = new SStack();
        for (String stem : stemmedList)
        {
            int rs = pm.searchString(compare, stem);
            if (rs != -1){
                matched.push(stem);
            }
        }
        return matched;
    }
}

