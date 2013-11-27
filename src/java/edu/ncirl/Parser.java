/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.ncirl;

import java.util.*;

/**
 *
 * @author sean
 */
public class Parser {

    public static int countDigits(String s) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            if (Character.isDigit(s.charAt(i))) {
                count++;
            }
        }
        return count;
    }

    public static ArrayList findIntersection(Set a, Set b) {
        ArrayList intersection = new ArrayList();

        for (Object x : a) {
            for (Object y : b) {
                if (x.equals(y)) {
                    intersection.add(x);
                }
            }
        }
        return intersection;
    }

    public static SStack StripSearch(String wordToStrip) {

        char prev_char;
        char next_char;
        boolean atLeastOne = false;
        boolean skipnext = false;
        Stack bigram = new Stack();
        StringBuilder currentWord = new StringBuilder();
        int j, k;
        //remove ' also but before or after stop word removal
        //wordToStrip = wordStrip.replaceAll("-", "").replaceAll("_", "");
        StringBuilder newWordList = new StringBuilder(wordToStrip.length());
        for (int i = 0; i < wordToStrip.length(); i++) {
            j = i + 1;
            k = i - 1;

            if (i > 0) {
                prev_char = wordToStrip.charAt(k);
            }
            if (i < (wordToStrip.length() - 1)) {
                next_char = wordToStrip.charAt(j);
            }
            switch (Character.toLowerCase(wordToStrip.charAt(i))) {
                case '.': // replace full stop with blank unless of type .net
                    if ((i > 0) && (i < (wordToStrip.length() - 1))) {
                        prev_char = wordToStrip.charAt(k);
                        next_char = wordToStrip.charAt(j);
                        if (Character.isWhitespace(prev_char) && Character.toLowerCase(next_char) == 'n') {
                            newWordList.append(wordToStrip.charAt(i));
                            currentWord.append(wordToStrip.charAt(i));
                        } else {
                            newWordList.append(" ");
                            currentWord = new StringBuilder();
                        }
                    }
                    ;
                    break;
                case ',': //replace commas with blank
                    newWordList.append(" ");
                    if ((currentWord.length() > 0) && !skipnext) {
                        bigram.push(currentWord);
                    }
                    currentWord = new StringBuilder();
                    skipnext = true;
                    break;
                case 'c': //special case for c#
                    newWordList.append(wordToStrip.charAt(i));
                    currentWord.append(wordToStrip.charAt(i));
                    if ((i < (wordToStrip.length() - 1))) {
                        next_char = wordToStrip.charAt(j);
                        if (next_char == '#') {
                            newWordList.append(wordToStrip.charAt(j));
                            currentWord.append(wordToStrip.charAt(j));
                        }
                    }
                    ;
                    break;
                case '+': //specoial case for c++
                    if ((i > 0) && (i < (wordToStrip.length() - 1))) {
                        prev_char = wordToStrip.charAt(k);
                        next_char = wordToStrip.charAt(j);
                        if (Character.toLowerCase(prev_char) == 'c' && Character.toLowerCase(next_char) == '+') {
                            newWordList.append(wordToStrip.charAt(i));
                            newWordList.append(wordToStrip.charAt(j));
                            currentWord.append(wordToStrip.charAt(i));
                            currentWord.append(wordToStrip.charAt(j));
                        }
                    }
                    ;
                    break;
                default:
                    if (Character.isDigit(wordToStrip.charAt(i))
                            || Character.isLetter(wordToStrip.charAt(i))
                            || Character.isWhitespace(wordToStrip.charAt(i))) {
                        newWordList.append(wordToStrip.charAt(i));

                        atLeastOne = true;
                        if (Character.isWhitespace(wordToStrip.charAt(i))) {
                            if ((currentWord.length() > 0) && !skipnext) {
                                bigram.push(currentWord);
                                skipnext = false;
                            }
                            currentWord = new StringBuilder();
                           
                        } else {
                            currentWord.append(wordToStrip.charAt(i));
                        }
                        //System.out.println("It's a letter or digit " + wordToStrip.charAt(i));
                       
                    }
            }
        }
        //System.out.println("New Word List " + newWordList);
        String str = newWordList.toString();
        String[] wordList = str.split("\\s+");
        SStack listOfWords = new SStack();
        for (String s : wordList) {
            int wordlen = s.trim().length();
            //System.out.println("New Word len " + wordlen + "digits " + countDigits(s.trim()));
            if ( // wordlen > 2 only accept if word more than two letters
                    wordlen < 25 //reject long words, probably garbage
                    && countDigits(s.trim()) < 5)//reject if more than fiv digits
            // && (countDigits(s.trim()) < (wordlen - 2))) mostly numbers, reject
            {
                listOfWords.push(s.trim().toLowerCase());
            }
        }
        Set<String> uniqueSet = new HashSet<String>(listOfWords);

        return listOfWords;
    }
}
