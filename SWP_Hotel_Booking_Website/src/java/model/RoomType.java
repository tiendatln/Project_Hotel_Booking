/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class RoomType {
    int room_type_id;
    String name_type; 
    String room_description;
    int room_capacity; 

    public RoomType() {
    }

    public RoomType(int room_type_id, String name_type, String room_description, int room_capacity) {
        this.room_type_id = room_type_id;
        this.name_type = name_type;
        this.room_description = room_description;
        this.room_capacity = room_capacity;
    }

    public RoomType(int room_type_id) {
        this.room_type_id = room_type_id;
    }                    
    
    public int getRoom_type_id() {
        return room_type_id;
    }

    public void setRoom_type_id(int room_type_id) {
        this.room_type_id = room_type_id;
    }

    public String getName_type() {
        return name_type;
    }

    public void setName_type(String name_type) {
        this.name_type = name_type;
    }

    public String getRoom_description() {
        return room_description;
    }

    public void setRoom_description(String room_description) {
        this.room_description = room_description;
    }

    public int getRoom_capacity() {
        return room_capacity;
    }

    public void setRoom_capacity(int room_capacity) {
        this.room_capacity = room_capacity;
    }
    
    
}
