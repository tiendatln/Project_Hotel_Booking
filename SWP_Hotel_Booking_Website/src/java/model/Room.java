/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class Room {

    private int room_id;
    private String room_name;
    private int room_price;
    private String room_img;
    private boolean room_status;
    private String room_description;
    private RoomType room_type;
    private Hotel hotel;

    public Room() {
    }

    public Room(int room_id, String room_name, int room_price, String room_img, boolean room_status, String room_description, RoomType room_type, Hotel hotel) {
        this.room_id = room_id;
        this.room_name = room_name;
        this.room_price = room_price;
        this.room_img = room_img;
        this.room_status = room_status;
        this.room_description = room_description;
        this.room_type = room_type;
        this.hotel = hotel;
    }

    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }

    public String getRoom_name() {
        return room_name;
    }

    public void setRoom_name(String room_name) {
        this.room_name = room_name;
    }

    public int getRoom_price() {
        return room_price;
    }

    public void setRoom_price(int room_price) {
        this.room_price = room_price;
    }

    public String getRoom_img() {
        return room_img;
    }

    public void setRoom_img(String room_img) {
        this.room_img = room_img;
    }

    public boolean isRoom_status() {
        return room_status;
    }

    public void setRoom_status(boolean room_status) {
        this.room_status = room_status;
    }

    public RoomType getRoom_type() {
        return room_type;
    }

    public void setRoom_type(RoomType room_type) {
        this.room_type = room_type;
    }

    public Hotel getHotel() {
        return hotel;
    }

    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }

    public String getRoom_description() {
        return room_description;
    }

    public void setRoom_description(String room_description) {
        this.room_description = room_description;
    }

}
