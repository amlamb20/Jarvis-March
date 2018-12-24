// Austin Lamb
// Transylvania University CS
// Principles of Programming Language
// November 12, 2018

// Point.java
// An object with a name, x-value, and a y-value.

import java.lang.Math;
public class Point {
    private String name;
    private double x, y;
    private double SAME_PT_SNTL = 111.0;

    // Constructor 1: Not passing in any values creates a dummy point.
    public Point() {
        this.name = "dummy";
        this.x = 0;
        this.y = 0;
    }

    // Constructor 2: Passing in a name, x-value, and a y-value creates a point.
    public Point(String name, double x, double y) {
        this.name = name;
        this.x = x;
        this.y = y;
    } 

    // getName
    // Returns the name of this point.
    public String getName() {
        return name;
    }

    // getX
    // Returns the x value of this point.
    public double getX() {
        return x;
    }

    // getY
    // Returns the y value of this point.
    public double getY() {
        return y;
    }

    // findLeftmost
    // Finds the leftmost of a passed in point and this point.
    public Point findLeftmost(Point pt) {
        if (this.getX() < pt.getX()) return this;
        else return pt;
    }
    
    // polarAngle
    // Finds polar angle of this point in relation to a passed in point. 
    // If the two points are equal, return SAME_PT_SNTL (111 radians)
    public double polarAngle(Point pt) {
        if (this == pt) return SAME_PT_SNTL;
        else return Math.atan2(pt.getY()-this.getY(), pt.getX()-this.getX());
    }

}