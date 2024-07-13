/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author tiend
 */
public class re_Item {
    private reservation re_id;
    private hotel hotel_id;
    private room room_id;
    private service service_id;
    private int quantity;

    public re_Item() {
    }

    public re_Item(reservation re_id, hotel hotel_id, room room_id, service service_id, int quantity) {
        this.re_id = re_id;
        this.hotel_id = hotel_id;
        this.room_id = room_id;
        this.service_id = service_id;
        this.quantity = quantity;
    }

    public reservation getRe_id() {
        return re_id;
    }

    public void setRe_id(reservation re_id) {
        this.re_id = re_id;
    }

    public hotel getHotel_id() {
        return hotel_id;
    }

    public void setHotel_id(hotel hotel_id) {
        this.hotel_id = hotel_id;
    }

    public room getRoom_id() {
        return room_id;
    }

    public void setRoom_id(room room_id) {
        this.room_id = room_id;
    }

    public service getService_id() {
        return service_id;
    }

    public void setService_id(service service_id) {
        this.service_id = service_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
}
