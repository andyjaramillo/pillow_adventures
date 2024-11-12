shader_type canvas_item;

uniform vec3 flash_color : source_color = vec3(1.0);
uniform float range : hint_range(0,2) = 10;
uniform float time;
uniform int is_on;

void fragment() {
	if (is_on == 1){

		vec4 t = texture(TEXTURE, UV);
		vec3 color_mix = mix(t.rgb, flash_color.rgb, time);
		COLOR = vec4(color_mix, t.a);
	}

	// Called for every pixel the material is visible on.
}