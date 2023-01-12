
createObject = choose(0, 1)

x = irandom_range(5, 1000);
y = irandom_range(300, 600);
customer_depth = irandom_range(1, 100);

if (createObject != 0) {
	instance_create_depth(x, y, customer_depth, obj_customer);
}

alarm[2] = random_range(3, 5)*room_speed;