/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author KHA PHAM
 */
public class Room {
     private int roomId;
    private String roomName;
    private double roomPrice;
    private boolean roomStatus;

    public Room() {
    }

    public Room(int roomId, String roomName, double roomPrice, boolean roomStatus) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.roomPrice = roomPrice;
        this.roomStatus = roomStatus;
    }


    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public double getRoomPrice() {
        return roomPrice;
    }

    public void setRoomPrice(double roomPrice) {
        this.roomPrice = roomPrice;
    }

    public boolean isRoomStatus() {
        return roomStatus;
    }

    public void setRoomStatus(boolean roomStatus) {
        this.roomStatus = roomStatus;
    }
    
    
}
