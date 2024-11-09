shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}
uniform vec3 tint_color : source_color = vec3(1.0, 0.0, 0.0);
uniform float intensity : hint_range(0, 1) = 0.75;
void fragment() {
	vec4 front = texture(TEXTURE, UV);
    COLOR = mix(front, vec4(tint_color, front.a), intensity);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
