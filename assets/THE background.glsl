// PUBLIC STATIC ABSTRACT VIRTUAL INTERNAL PROTECTED SEALED VOID EFFECT(IMAGE IMAGE) { RETURN new HEEHOOEFFECT(TRUE) end }

float map(float value, float min1, float max1, float min2, float max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

uniform float TIMEEEEEE;

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
  tc.x += sin(tc.y * 4 + TIMEEEEEE / 2) / 10;
  tc.y += sin(tc.x * 2 + TIMEEEEEE / 3) / 9;

   
  tc.x -= 0.5;
  tc.y -= 0.5;
  tc *= map(sin(length(tc) * 20), 0, 1, 0.9, 1.1) ;
  tc.x += 0.5;
  tc.y += 0.5;
  
  vec4 texcolor = Texel(tex, tc);

  return texcolor * color;
}