/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author tiend
 */
public class roomType {
    private int room_type_id;
    private String name_type;
    private String room_description;
    private int room_capacity;

    /**
     *
     */
    public roomType() {
    }

    public roomType(int room_type_id) {
        this.room_type_id = room_type_id;
    }

    /**
     *
     * @param room_type_id
     * @param name_type
     * @param room_capacity
     */
    public roomType(int room_type_id, String name_type, int room_capacity) {
        this.room_type_id = room_type_id;
        this.name_type = name_type;
        this.room_capacity = room_capacity;
    }

    /**
     *
     * @param roomtype_id
     * @param name_type
     * @param room_description
     * @param room_capacity
     */
    public roomType(int roomtype_id, String name_type, String room_description, int room_capacity) {
        this.room_type_id = roomtype_id;
        this.name_type = name_type;
        this.room_description = room_description;
        this.room_capacity = room_capacity;
    }

    /**
     *
     * @return
     */
    public int getRoom_type_id() {
        return room_type_id;
    }

    /**
     *
     * @param room_type_id
     */
    public void setRoom_type_id(int room_type_id) {
        this.room_type_id = room_type_id;
    }

    /**
     *
     * @return
     */
    public String getName_type() {
        return name_type;
    }

    /**
     *
     * @param name_type
     */
    public void setName_type(String name_type) {
        this.name_type = name_type;
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
    public int getRoom_capacity() {
        return room_capacity;
    }

    /**
     *
     * @param room_capacity
     */
    public void setRoom_capacity(int room_capacity) {
        this.room_capacity = room_capacity;
    }
    
}
