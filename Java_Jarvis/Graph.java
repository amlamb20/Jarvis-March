// Austin Lamb
// Transylvania University CS
// Principles of Programming Language
// November 12, 2018

// Graph.java
// An object that has a vector of Point objects.

import java.io.*;
import java.util.Vector;
import java.lang.Math;
public class Graph {
    private Vector<Point> graphPoints = new Vector<Point>();
    private double SAME_PT_SNTL = 111.0;

    // Constructor 1: No file passed in creates an empty graph.
    public Graph() {}

    // Constructor 2: Takes in a file and reads it into a Graph object.
    public Graph(String fileName) {

        try {
            FileReader inFile = new FileReader(fileName);
            BufferedReader in = new BufferedReader(inFile);
            String line = null;
            while((line = in.readLine()) != null) {
                String[] values = line.split(" ");
                
                // Ensure the values array received 3 variables.
                if (values.length != 3) {
                    in.close();
                    throw new Exception("There was an issue with one or more points in your input file.\n Make sure all points follow this format: A 2.7 3.0");
                }
                else {
                    Point pt = new Point(values[0],Double.parseDouble(values[1]),Double.parseDouble(values[2]));
                    addPoint(pt);
                }
            }

            in.close();
        }

        catch (Exception ex) {
            System.out.println(ex.getMessage());
            System.exit(1);
        }
    }
    
    // addPoint
    // Adds a point onto the graphPoints vector.
    public void addPoint(Point pt) {
        graphPoints.add(pt);
    }

    // findLowPoint
    // Finds the lowest point on the graph.
    public Point findLowPoint() {
        Point answer = firstPoint();
        Point currentPt = new Point();
        for (int i=0; i < getSize(); ++i) {
            currentPt = getNthPoint(i);
            if (currentPt.getY() < answer.getY()) answer = getNthPoint(i);
            if (currentPt.getY() == answer.getY()) answer = currentPt.findLeftmost(answer);
        }
        return answer;
    }

    // smallestAngle
    // Returns point with the smallest angle >= 0 relative to this point. If none exist, return this point.
    public Point smallestAngle(Point pX) {
        
        // Create an array of polar angles.
        int size = getSize();
        double angleArray[] = new double[size];
        for (int i=0; i < size; ++i) {
            angleArray[i] = pX.polarAngle(getNthPoint(i));
        }

        // Set a current answer, ensuring it's valid.
        int answer = 0;
        while ((angleArray[answer] == SAME_PT_SNTL) || (angleArray[answer] < 0) || (angleArray[answer] == Math.PI)) {
            answer++;
            // if no valid answer, return pX.
            if (answer == size) return pX;
        }

        // Look for smallest angle >= 0 in angleArray.
        for (int i=0; i < size; ++i) {

            // Compare i-th angle to answer. If i-th angle is smaller, set to answer.
            if ((angleArray[i] >= 0) && (angleArray[i] <= angleArray[answer])) {
                answer = i;
            }
        }

        return getNthPoint(answer);
    }

    // largestAngle
    // Returns point with the largest angle <= 0 relative to this point. If none exist, return this point.
    public Point largestAngle(Point pX) {
        int size = getSize();
        
        // Create an array of polar angles.
        double angleArray[] = new double[size];
        for (int i=0; i < size; ++i) {
            angleArray[i] = pX.polarAngle(getNthPoint(i));
        }

        // Set a current answer, setting it to first angle that is <= 0 or pi.
        int answer = 0;
        while ((angleArray[answer] > 0) && (angleArray[answer] != Math.PI)) {
            answer++;
            // if no valid answer, return pX.
            if (answer == size) return pX;
        }

        // If answer has an angle of pi, return it's corresponding point.
        if (angleArray[answer] == Math.PI) return getNthPoint(answer);

        // Look for largest angle <= 0 in angleArray.
        for (int i=0; i < size; ++i) {

            // If an angle of pi angle is found, return it's corresponding point.
            if (angleArray[i] == Math.PI) {
                return getNthPoint(i);
            }

            // Search for the largest angle <= 0 in angleArray.
            if ((angleArray[i] <= 0) && (angleArray[i] <= angleArray[answer])) {
                answer = i;
            }
        }

        return getNthPoint(answer);
    }

    // getNthPoint
    // Returns point from the graphPoints vector at the passed in index.
    public Point getNthPoint(int index) {
        return graphPoints.get(index);
    }

    // firstPoint
    // Returns the first point in the vector of points.
    public Point firstPoint() {
        return graphPoints.firstElement();
    }

    // getSize
    // Returns the size of the graphPoints vector.
    public int getSize() {
        return graphPoints.size();
    }

    // printGraph
    // Prints elements of graphPoints out to the screen in order.
    public void printGraph() {
        for (int i=0; i < getSize(); ++i) {
            System.out.println(getNthPoint(i).getName());
        }
    }
}