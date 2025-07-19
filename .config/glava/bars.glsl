// WAL-COLORS-START
uniform vec3 accent_1 = vec3(0.647, 0.203, 0.207);
uniform vec3 accent_2 = vec3(0.698, 0.603, 0.462);
uniform vec3 bg_color  = vec3(0.003, 0.003, 0.007);
uniform vec3 fg_color  = vec3(0.698, 0.733, 0.721);
// WAL-COLORS-END

/* Center line thickness (pixels) */
#define C_LINE 1
/* Width (in pixels) of each bar */
#define BAR_WIDTH 4
/* Width (in pixels) of each bar gap */
#define BAR_GAP 2
/* Outline width (in pixels, set to 0 to disable outline drawing) */
#define BAR_OUTLINE_WIDTH 1

/* Amplify magnitude of the results each bar displays */
#define AMPLIFY 700

/* Use alpha channel — required for transparency */
#define USE_ALPHA 1

/* Gradient strength */
#define GRADIENT_POWER 60

/* Gradient factor */
#define GRADIENT (clamp(d / float(GRADIENT_POWER), 0.0, 1.0))

/* Bar color — smoothly mixes two Pywal colors */
#define COLOR vec4(mix(accent_2, accent_1, GRADIENT), 1.0)

/* Outline color — semi-transparent Pywal background color */
#define BAR_OUTLINE vec4(bg_color, 0.4)

/* Direction that the bars are facing, 0 for inward, 1 for outward */
#define DIRECTION 0
/* Whether to switch left/right audio buffers */
#define INVERT 0
/* Whether to flip the output vertically */
#define FLIP 0
/* Whether to mirror output along `Y = X` */
#define MIRROR_YX 0

