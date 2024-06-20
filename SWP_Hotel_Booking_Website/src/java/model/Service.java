/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class Service {

    private int service_id;
    private String service_description;
    private int service_price;
    private Hotel hotel;

    public Service() {
    }

    public Service(int service_id, String service_description, int service_price, Hotel hotel) {
        this.service_id = service_id;
        this.service_description = service_description;
        this.service_price = service_price;
        this.hotel = hotel;
    }

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public String getService_description() {
        return service_description;
    }

    public void setService_description(String service_description) {
        this.service_description = service_description;
    }

    public int getService_price() {
        return service_price;
    }

    public void setService_price(int service_price) {
        this.service_price = service_price;
    }

    public Hotel getHotel() {
        return hotel;
    }

    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }

}
