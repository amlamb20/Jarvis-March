// Austin Lamb
// Transylvania University CS
// Principles of Programming Language
// November 12, 2018

// Jarvis.java
// JARVIS' MARCH
// This is an implementation of "Jarvis' March," an algorithm intended to create a path of points in a graph
// in such that it encloses all points using the smallest amount of distace (known as the convex hull).

// Sources Cited: 
// JDK: https://docs.oracle.com/javase/8/docs/technotes/guides/install/windows_jdk_install.html#BABGDJFH
// Vector: https://www.youtube.com/watch?v=RQP1HIOnV0A
// Constructor: https://docstore.mik.ua/orelly/java-ent/jnut/ch03_02.htm
// String to double: http://www.java67.com/2015/06/how-to-convert-string-to-double-java-example.html
// Try, catch, reading in: https://www.youtube.com/watch?v=oP7Kd74iVnk
// Calling method w/o object: https://stackoverflow.com/questions/10828817/calling-method-without-object
// Declaring arrays: http://web.cerritos.edu/pnguyen/SitePages/cis103/java_arrays.htm
// Throwing exceptions: https://www.webucator.com/how-to/how-throw-an-exception-java.cfm

// File is passed into the command line as follows:
// java Jarvis inFileName

// Input file format is as follows:
// point1 1.3 3.7
// point2 2.0 0.0

import java.io.*;
public class Jarvis {

    // Main
    // Main is designed to take in an array of strings 'args[]' via command line.
    // Only one argument should be read into args[], which is an input file.
    public static void main(String[] args) {
        Point p0 = new Point();
        Point pX = new Point();
        Point pY = new Point();
        Graph answerSet = new Graph();
        int currentString = 1;
        
        // Ensure that a file was passed into the command line correctly. If not, print out error and exit.
        if (args.length == 0) {
            System.out.println("Error: file not passed in.\n Command line argument is as follows: java Jarvis inFileName");
            System.exit(1);
        }

        if (args.length > 1) {
            System.out.println("Error: too many arguments.\n Command line argument is as follows: java Jarvis inFileName");
            System.exit(1);
        }
    
        // Read in main graph from input file.
        Graph graph = new Graph(args[0]);

        // Find p0, the lowest leftmost point. Set pX to p0.
        p0 = graph.findLowPoint();
        pX = p0;

        do {     
            // If in first string...
            if (currentString == 1) {
                // find pY, the point w/ the smallest angle >= 0.
                pY = graph.smallestAngle(pX);
                // If pY returns pX (no answers found), set string to 2.
                if (pX == pY) {
                    currentString = 2;
                }
            }

            // If in second string...
            if (currentString == 2) {
                // find pY, the point w/ the largest angle <= 0.
                pY = graph.largestAngle(pX);
            }

            // add pX to answerSet. Set pX to pY.
            answerSet.addPoint(pX);
            pX = pY;

        } while (pX != p0); // do while pX is not equal to p0.

        // Print answerSet to the screen.
        System.out.println("Answer set:");
        answerSet.printGraph();

    }

}