package com.model;

public class Rooms {
	
	private int id;
	private int room_no;
	private String category;
	private float amount_per_day;
	private String availability;
	
	public Rooms(int id, String availability) {
		this.id = id;
		this.availability = availability;
	}

	public Rooms(int room_no, String category, float amount_per_day, String availability) {
		this.room_no = room_no;
		this.category = category;
		this.amount_per_day = amount_per_day;
		this.availability = availability;
	}
	
	public Rooms(int id, int room_no, String category, float amount_per_day, String availability) {
		this.id = id;
		this.room_no = room_no;
		this.category = category;
		this.amount_per_day = amount_per_day;
		this.availability = availability;
	}
	
	public Rooms(int id, int room_no, String category, String availability) {
		this.id = id;
		this.room_no = room_no;
		this.category = category;
		this.availability = availability;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getRoom_no() {
		return room_no;
	}
	
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
	
	public float getAmount_per_day() {
		return amount_per_day;
	}
	
	public void setAmount_per_day(float amount_per_day) {
		this.amount_per_day = amount_per_day;
	}
	
	public String getAvailability() {
		return availability;
	}
	
	public void setAvailability(String availability) {
		this.availability = availability;
	}

	@Override
	public String toString() {
		return "Rooms [room_no=" + room_no + ", category=" + category + ", amount_per_day=" + amount_per_day
				+ ", availability=" + availability + "]";
	}
}
