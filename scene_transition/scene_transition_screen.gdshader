shader_type canvas_item;

uniform sampler2D noise_texture;
uniform sampler2D dissolve_noise_texture;

uniform vec4 colour_1: source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 colour_2: source_color = vec4(0.0, 0.0, 0.0, 1.0);

uniform float tiling_factor: hint_range(1.0, 10.0) = 1.0;
uniform float move_speed : hint_range(-2.0, 2.0) = 0.1;
uniform float substraction_speed : hint_range(0.1, 5.0) = 1.0;

void fragment() {
	vec2 uv = UV * tiling_factor;
	
	uv.y += TIME * move_speed;
	
	uv = fract(uv);
	
	float noise_value = texture(noise_texture, uv).r;
	float dissolve_value = texture(dissolve_noise_texture, uv).r;
	
	float substraction_factor = sin(TIME * substraction_speed);
	float final_value = noise_value - (substraction_factor * dissolve_value);
	
	vec4 f_color = mix(colour_2, colour_1, final_value);
	
	COLOR = f_color;
}