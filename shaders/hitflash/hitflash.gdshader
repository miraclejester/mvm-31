shader_type canvas_item;
uniform vec4 flash_color : source_color = vec4(1.0);
uniform bool enabled = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	vec3 final_color = mix(original_color.rgb, flash_color.rgb, float(enabled));
	COLOR = vec4(final_color.rgb, original_color.a);
}
