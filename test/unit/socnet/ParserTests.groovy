package socnet
import edu.ncirl.*

import grails.test.*

class ParserTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testParseAtSign() {
         // strip @ from text
        String s = "This is a test to see if @ is stripped";
        String expResult = "this is a test to see if is stripped";
        SStack result = Parser.StripSearch(s);
        assertEquals(expResult, result.toString());
    }
     void testParsePlus() {
        // want to keep + sign only if c+
        String s = "This is a test to see if + is stripped";
        String expResult = "this is a test to see if is stripped";
        SStack result = Parser.StripSearch(s);
        assertEquals(expResult, result.toString());
     }
     void testParseCPlus() {
        // want to keep + sign only if c+
        String s = "This is a test to see if c++ is stripped";
        String expResult = "this is a test to see if c++ is stripped";
        SStack result = Parser.StripSearch(s);
        assertEquals(expResult, result.toString());
     }
     void testParseApostrope() {
        // strip ' from text
        String s = "This is a test to see I'm is stripped";
        String expResult = "this is a test to see im is stripped";
        SStack result = Parser.StripSearch(s);
        assertEquals(expResult, result.toString());
     }
     void testParseCommandApostrope() {
        // strip ' and , from text
        String s = "This is a test to see I'm, is stripped";
        String expResult = "this is a test to see im is stripped";
        SStack result = Parser.StripSearch(s);
        assertEquals(expResult, result.toString());
    }

    void testCSharp() {
         // test c# remains from text
        String s = "This is a test to see if c# is not stripped";
        String expResult = "this is a test to see if c# is not stripped";
        SStack result = Parser.StripSearch(s);
        println result.toString();
        assertEquals(expResult, result.toString());
    }
    void testDotNet() {
         // test c# remains from text
        String s = "This is a test to see if .net is not stripped";
        String expResult = "this is a test to see if .net is not stripped";
        SStack result = Parser.StripSearch(s);
        println result.toString();
        assertEquals(expResult, result.toString());
    }
    void testDeveloperStemmed() {
        String stopped = "developer";
        SStack stemmed = Stemmer.StemText(stopped);
        assertEquals("develop",stemmed.toString());
        stopped = "development";
        stemmed = Stemmer.StemText(stopped);
        assertEquals("develop",stemmed.toString());
    }
    void testGenrateStemmed() {
        String stopped = "generate";
        SStack stemmed = Stemmer.StemText(stopped);
        assertEquals("generat",stemmed.toString())
        stopped = "generation";
        stemmed = Stemmer.StemText(stopped);
        assertEquals("generat",stemmed.toString());
        stopped = "generated";
        stemmed = Stemmer.StemText(stopped);
        assertEquals("generat",stemmed.toString());
    }
      void testAnimateStemmed() {
        String stopped = "animation";
        SStack stemmed = Stemmer.StemText(stopped);
        assertEquals("animat",stemmed.toString())
        stopped = "animator";
        stemmed = Stemmer.StemText(stopped);
        assertEquals("animat",stemmed.toString());
        stopped = "animate";
        stemmed = Stemmer.StemText(stopped);
        assertEquals("animat",stemmed.toString());
    }
}
