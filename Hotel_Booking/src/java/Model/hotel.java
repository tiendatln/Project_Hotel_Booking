/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author tiend
 */
public class hotel {
    private int hotel_id;
    private String hotel_name;
    private String hotel_address;
    private String hotel_img;
    private String hotel_description;
    private account username;

    /**
     *
     */
    public hotel() {
    }

    public hotel(int hotel_id) {
        this.hotel_id = hotel_id;
    }

    /**
     *
     * @param hotel_id
     * @param hotel_name
     * @param hotel_address
     * @param hotel_img
     * @param hotel_description
     */
    public hotel(int hotel_id, String hotel_name, String hotel_address, String hotel_img, String hotel_description) {
        this.hotel_id = hotel_id;
        this.hotel_name = hotel_name;
        this.hotel_address = hotel_address;
        this.hotel_img = hotel_img;
        this.hotel_description = hotel_description;
    }

    /**
     *
     * @param hotel_id
     * @param hotel_name
     * @param hotel_address
     * @param hotel_img
     * @param hotel_description
     * @param username
     */
    public hotel(int hotel_id, String hotel_name, String hotel_address, String hotel_img, String hotel_description, account username) {
        this.hotel_id = hotel_id;
        this.hotel_name = hotel_name;
        this.hotel_address = hotel_address;
        this.hotel_img = hotel_img;
        this.hotel_description = hotel_description;
        this.username = username;
    }

    /**
     *
     * @return
     */
    public account getUsername() {
        return username;
    }

    /**
     *
     * @param username
     */
    public void setUsername(account username) {
        this.username = username;
    }

    /**
     *
     * @return
     */
    public int getHotel_id() {
        return hotel_id;
    }

    /**
     *
     * @param hotel_id
     */
    public void setHotel_id(int hotel_id) {
        this.hotel_id = hotel_id;
    }

    /**
     *
     * @return
     */
    public String getHotel_name() {
        return hotel_name;
    }

    /**
     *
     * @param hotel_name
     */
    public void setHotel_name(String hotel_name) {
        this.hotel_name = hotel_name;
    }

    /**
     *
     * @return
     */
    public String getHotel_address() {
        return hotel_address;
    }

    /**
     *
     * @param hotel_address
     */
    public void setHotel_address(String hotel_address) {
        this.hotel_address = hotel_address;
    }

    /**
     *
     * @return
     */
    public String getHotel_img() {
        return hotel_img;
    }

    /**
     *
     * @param hotel_img
     */
    public void setHotel_img(String hotel_img) {
        this.hotel_img = hotel_img;
    }

    /**
     *
     * @return
     */
    public String getHotel_description() {
        return hotel_description;
    }

    /**
     *
     * @param hotel_description
     */
    public void setHotel_description(String hotel_description) {
        this.hotel_description = hotel_description;
    }
    
}
