/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author tiend
 */
public class room {
    private int room_id;
    private String room_name;
    private int room_price;
    private String room_img;
    private boolean room_status;
    private String room_description;
    private roomType room_type;
    private int room_capacity;
    private hotel hotel;

    /**
     *
     */
    public room() {
    }

    public room(int room_id, hotel hotel) {
        this.room_id = room_id;
        this.hotel = hotel;
    }

    /**
     *
     * @param room_img
     */
    public room(String room_img) {
        this.room_img = room_img;
    }

    public room(int room_id) {
        this.room_id = room_id;
    }


    public room(int room_id, String room_name, int room_price, String room_img, boolean room_status, String room_description, roomType room_type, int room_capacity, hotel hotel) {
        this.room_id = room_id;
        this.room_name = room_name;
        this.room_price = room_price;
        this.room_img = room_img;
        this.room_status = room_status;
        this.room_description = room_description;
        this.room_type = room_type;
        this.room_capacity = room_capacity;
        this.hotel = hotel;
    }

    public int getRoom_capacity() {
        return room_capacity;
    }

    public void setRoom_capacity(int room_capacity) {
        this.room_capacity = room_capacity;
    }

    /**
     *
     * @return
     */
    public int getRoom_id() {
        return room_id;
    }

    /**
     *
     * @param room_id
     */
    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }

    /**
     *
     * @return
     */
    public String getRoom_name() {
        return room_name;
    }

    /**
     *
     * @param room_name
     */
    public void setRoom_name(String room_name) {
        this.room_name = room_name;
    }

    /**
     *
     * @return
     */
    public int getRoom_price() {
        return room_price;
    }

    /**
     *
     * @param room_price
     */
    public void setRoom_price(int room_price) {
        this.room_price = room_price;
    }

    /**
     *
     * @return
     */
    public String getRoom_img() {
        return room_img;
    }

    /**
     *
     * @param room_img
     */
    public void setRoom_img(String room_img) {
        this.room_img = room_img;
    }

    /**
     *
     * @return
     */
    public boolean isRoom_status() {
        return room_status;
    }

    /**
     *
     * @param room_status
     */
    public void setRoom_status(boolean room_status) {
        this.room_status = room_status;
    }

    /**
     *
     * @return
     */
    public String getRoom_description() {
        return room_description;
    }

    /**
     *
     * @param room_description
     */
    public void setRoom_description(String room_description) {
        this.room_description = room_description;
    }

    /**
     *
     * @return
     */
    public roomType getRoom_type() {
        return room_type;
    }

    /**
     *
     * @param room_type
     */
    public void setRoom_type(roomType room_type) {
        this.room_type = room_type;
    }

    /**
     *
     * @return
     */
    public hotel getHotel() {
        return hotel;
    }

    /**
     *
     * @param hotel
     */
    public void setHotel(hotel hotel) {
        this.hotel = hotel;
    }

    @Override
    public String toString() {
        return "room{" + "room_id=" + room_id + ", room_name=" + room_name + ", room_price=" + room_price + ", room_img=" + room_img + ", room_status=" + room_status + ", room_description=" + room_description + ", room_type=" + room_type + ", hotel=" + hotel + '}';
    }
    
}
