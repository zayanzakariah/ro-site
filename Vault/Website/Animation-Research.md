# Animation Research Brief: Ro Agency Website

**Date**: 2026-04-06  
**Focus**: 3D Heroes, Roundabout Sections, Center-Aligned Layouts, and CDN Stack for Vanilla HTML

---

## 1. 3D HERO CENTERPIECES

### Recommended Approach for Ro
**Glass Sphere with Subtle Internal Motion** — minimalist, brand-aligned, no Three.js expertise needed.
- Use Vanta.js `Topology` effect (lightweight, ~120kb minified) as primary hero
- Alternative: rotating wireframe sphere (Three.js + GSAP for interaction)
- For Braun aesthetic (charcoal + orange #D9541E): Vanta Topology with warm accent colors works best
- Motion: slow rotation, responsive to mouse proximity, auto-resume on mouse-out

### Reference Sites & 3D Elements Used

1. **Bruno Simon Portfolio** (bruno-simon.com)
   - Element: Full 3D interactive environment (vehicle exploration)
   - Tech: Three.js with custom shaders, hero loads spatialized audio
   - Complexity: High (full drivable world)

2. **Lando Norris Official Website** (Awwwards Site of Year 2025)
   - Element: Rotating 3D helmet + cinematic scroll sequences
   - Tech: Webflow + WebGL + Rive motion design
   - Brand fit: HIGH (motorsport, bold lime green, smooth rotation)

3. **Messenger (Awwwards Site of Year 2025)**
   - Element: Tiny WebGL planet with delivery animation
   - Tech: WebGL with interactive postal metaphor
   - Complexity: Medium

4. **Carl Gordon Portfolio** (Interactive 3D Hero Section)
   - Element: Colorful interactive 3D geometry in hero
   - Tech: Three.js with mouse interactivity
   - Brand fit: Creative agency (bright colors, playful interaction)

5. **Dora Expo: AI-Era Web Design**
   - Element: 3D grid animated background + hero section blur
   - Tech: Three.js with grid topology
   - Brand fit: Tech-forward, clean geometry

### Library Recommendations

**Vanta.js** (Best for Ro)
- Pros: No Three.js knowledge required, ~120kb, 13 built-in effects, lightweight
- Effects matching Braun: Topology, Waves, Halo
- CDN: `https://cdn.jsdelivr.net/npm/vanta@latest/dist/vanta.topology.min.js`
- Pattern: Initialize on hero div, optional mouse interaction, auto-responsive

**Three.js** (For Custom Control)
- Pros: Full control, infinite customization, industry standard
- Cons: 120kb minimum, requires graphics knowledge
- CDN: `https://cdnjs.cloudflare.com/ajax/libs/three.js/r134/three.min.js`
- Best for: Displaced plane, glass sphere vortex, custom shaders

### Implementation Pattern (Pseudocode)

```javascript
// Vanta Approach (Recommended for Ro)
VANTA.Topology({
  el: '#hero',
  mouseControls: true,
  touchControls: true,
  minHeight: 200,
  minWidth: 200,
  scale: 1.0,
  scaleMobile: 1.0,
  color: 0x1a1a1a,      // charcoal
  backgroundColor: 0xffffff,
  points: 8,
  maxDistance: 25,
  speed: 0.6
})

// Three.js Approach (Wireframe Sphere)
const geometry = new IcosahedronGeometry(3, 8)
const material = new MeshPhongMaterial({
  emissive: 0xD9541E,   // orange accent
  wireframe: true,
  transparent: true,
  opacity: 0.8
})
const sphere = new Mesh(geometry, material)
scene.add(sphere)
// Rotate on scroll via GSAP ScrollTrigger
```

---

## 2. ROUNDABOUT / CIRCULAR SCROLL-ROTATION SECTIONS

### Recommended Approach
**GSAP ScrollTrigger Pin + Horizontal Translate with Rotation** — standard pattern, mature, proven.
- 3 cards arranged radially (120° apart)
- ScrollTrigger pins section, extends animation duration (`end: "+=500%"`)
- Tween animates `xPercent` to translate cards horizontally
- Optional: Stagger rotation (rotateZ) as cards enter/exit viewport
- Cards remain in radial layout; carousel effect is horizontal shift with rotation timing

### Reference Sites & Implementations

1. **Codrops: Mastering Carousels with GSAP (2025)**
   - Pattern: `horizontalLoop()` helper + `rotateY` transforms
   - URL: https://tympanus.net/codrops/2025/04/21/mastering-carousels-with-gsap-from-basics-to-advanced-animation/
   - Technique: Absolute positioning, stagger easing, callback on index change

2. **Envato Tuts+: Horizontal Scroll with GSAP & ScrollTrigger**
   - Pattern: Pin + containerAnimation + nested ScrollTriggers
   - URL: https://webdesign.tutsplus.com/create-horizontal-scroll-animations-with-gsap-scrolltrigger--cms-108881t
   - Key: `invalidateOnRefresh: true` for responsive behavior

3. **GSAP Community Forum: ScrollTrigger Carousel Examples**
   - URL: https://gsap.com/community/forums/topic/33897-scrolltrigger-rotate-on-each-slide/
   - Technique: Watch slide entry, trigger caption reveals on horizontal movement

### Implementation Pattern (Pseudocode)

```javascript
// Pin & Horizontal Scroll Setup
gsap.registerPlugin(ScrollTrigger)

const section = document.querySelector('.roundabout-section')
const cards = document.querySelectorAll('.card')

gsap.to(cards, {
  xPercent: -300,  // Translate 3 cards off-screen
  scrollTrigger: {
    trigger: section,
    pin: true,
    scrub: 1,
    start: 'top center',
    end: '+=500%',
    invalidateOnRefresh: true,
    onUpdate: (self) => {
      // Optional: update active card index
      const progress = self.progress
      const activeIndex = Math.floor(progress * cards.length)
    }
  }
})

// Staggered Rotation (Optional)
cards.forEach((card, i) => {
  gsap.to(card, {
    rotateZ: i % 2 === 0 ? 5 : -5,
    duration: 1,
    scrollTrigger: {
      trigger: card,
      containerAnimation: /* reference to main tween */,
      start: 'left center',
      end: 'center center'
    }
  })
})
```

---

## 3. CENTER-ALIGNED HERO LAYOUTS

### Recommended Composition for Ro
**Oversized Typography + Vanta Background + Marquee Subtext**
- H1: 120–160px serif or modern sans, centered, charcoal (#1a1a1a)
- Vanta Topology background (orange accent, subtle motion)
- Subline: animated marquee text or split reveal animation
- CTA: single primary button, white/orange contrast
- Negative space: 40%+ white space above and below headline

### Five Premium Agency Reference Sites

1. **ArtVersion**
   - Approach: Minimalist hero, white space, bold centered typography, scattered photo elements
   - Layout: Single headline + negative space + small photo carousel
   - Brand tone: Elegant, editorial, understated power

2. **Bennet Tea**
   - Approach: Pastel pink hero with unconventional grid layout, bold typographic design, subtle borders
   - Layout: Type in grid frame, centered composition
   - Brand tone: Premium, refined, contemporary

3. **Cretivox**
   - Approach: Clean grid layout, refined typography, understated power
   - Layout: Centered type with breathing room
   - Brand tone: Sophisticated, editorial

4. **Monolith**
   - Approach: Oversized dominant type, clean layout, kinetic lettering
   - Layout: Full-height centered headline, minimal secondary elements
   - Brand tone: Bold, striking, modern

5. **ThreeJS Agency Portfolio (Generic)**
   - Approach: Minimalist hero, bold centered typography + 3D element behind
   - Layout: Type overlay on 3D scene, single CTA below
   - Brand tone: Technical yet elegant

### Ways Premium Agencies Fill Centered Space

1. **3D Background Element** — Vanta effect or Three.js object behind text (non-intrusive, depth)
2. **Oversized Typography** — 120–160px headline dominates; fills void with scale
3. **Animated Marquee or Reveal** — Subtext animates in on load (motion fills silence)
4. **Animated Gradient Mesh** — Orbiting color blobs in background, subtle parallax
5. **Particle Field** — Drifting geometric shapes, responds to cursor (interactive fill)

**For Ro**: Oversized serif H1 (charcoal) + Vanta Topology background (orange accent) + single-line subheading with fade-in animation. This avoids emptiness while staying true to Braun minimalism.

---

## 4. LIBRARY STACK FOR VANILLA HTML (NO BUILD STEP)

### Recommended Minimum Stack

| Library | Purpose | CDN URL | Size (min+gzip) | Notes |
|---------|---------|---------|-----------------|-------|
| **GSAP** | Timeline animation, ScrollTrigger | `https://cdnjs.cloudflare.com/ajax/libs/gsap/3.13.0/gsap.min.js` | 33kb | Core animation engine |
| **ScrollTrigger** | Scroll-triggered animations | `https://cdnjs.cloudflare.com/ajax/libs/gsap/3.13.0/ScrollTrigger.min.js` | 30kb | Must load after GSAP |
| **Lenis** | Smooth scroll | `https://cdn.jsdelivr.net/npm/@studio-freight/lenis@latest` | 8kb | Install via npm or jsDelivr |
| **Vanta.js** | 3D hero background | `https://cdn.jsdelivr.net/npm/vanta@latest/dist/vanta.topology.min.js` | 120kb | Three.js included; pick one effect |
| **Motion One** (Optional) | DOM element animation | `https://cdn.jsdelivr.net/npm/motion@latest/dist/motion.js` | 2.3kb | Simpler alternative to GSAP for basic animations |

### Implementation Example (HTML)

```html
<!DOCTYPE html>
<html>
<head>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r134/three.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/vanta@latest/dist/vanta.topology.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.13.0/gsap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.13.0/ScrollTrigger.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@studio-freight/lenis@latest"></script>
</head>
<body>
  <section id="hero" class="hero">
    <h1>Your Headline</h1>
  </section>
  
  <section class="roundabout">
    <div class="card">Card 1</div>
    <div class="card">Card 2</div>
    <div class="card">Card 3</div>
  </section>

  <script>
    // Vanta Hero
    VANTA.Topology({
      el: '#hero',
      color: 0x1a1a1a,
      backgroundColor: 0xffffff
    })

    // Lenis Smooth Scroll
    const lenis = new Lenis()
    lenis.on('scroll', ScrollTrigger.update)
    gsap.ticker.add(time => lenis.raf(time * 1000))
    gsap.ticker.lagSmoothing(0)

    // GSAP + ScrollTrigger animations
    gsap.registerPlugin(ScrollTrigger)
    // ... animation code
  </script>
</body>
</html>
```

### Why This Stack

- **GSAP + ScrollTrigger**: Industry standard, mature, proven at scale, no competitors
- **Lenis**: Best smooth scroll feel (Locomotive Scroll now unmaintained)
- **Vanta.js**: Three.js bundled, zero graphics knowledge required
- **Motion One**: Light optional layer for simple reveals (can skip if GSAP enough)
- **Total footprint**: ~193kb (one-time download, heavily cached)

---

## 5. RISKS & GOTCHAS

### Performance & Core Web Vitals

1. **LCP (Largest Contentful Paint) Risk**: Vanta/Three.js hero may delay LCP if GPU-limited. Mitigation: preload Three.js CDN, use async loading for effects, test on throttled devices (slow 4G).

2. **Layout Shift from Roundabout Section**: Pin animation can cause CLS if card heights not fixed or viewport scrollbar appears. Mitigation: set explicit heights on card container, use `scrollbar-gutter: stable`.

### Browser Compatibility

3. **WebGL Fallback**: Older browsers (IE11, mobile Safari <15) don't support WebGL. Vanta gracefully degrades to static background. For Three.js custom hero, no fallback—test on target devices first.

4. **GSAP ScrollTrigger Mobile Edge Case**: Pinned sections + mobile viewport resizing can cause animation to "jump" or not respct new end value. Mitigation: `invalidateOnRefresh: true` and test iOS Safari pinch-zoom behavior.

### Animation Complexity

5. **Scroll Performance on Low-End Mobile**: Complex ScrollTrigger timelines (e.g., nested pinned sections + Vanta + smooth scroll) can cause frame drops. Test on Pixel 4a or iPhone SE. Fallback: disable smooth scroll (Lenis) on mobile, use CSS-only versions of secondary animations.

### CDN Reliability

6. **Three.js R134 Pinned Version**: CDN version may become stale. Monitor `three.js` releases; consider updating to r150+ yearly. Vanta auto-updates via jsdelivr `@latest`.

7. **Lenis Fork Warning**: Original Locomotive Scroll is unmaintained. Lenis is maintained but smaller ecosystem. Ensure fork doesn't diverge from stable releases (check GitHub activity monthly).

---

## References & Source URLs

### 3D Hero Animation
- [Three.js Journey (Bruno Simon)](https://threejs-journey.com/)
- [Building Interactive 3D Hero Animation](https://www.matsimon.dev/blog/building-an-interactive-3d-hero-animation)
- [Awwwards Best 3D Websites](https://www.awwwards.com/websites/3d/)
- [Vanta.js Official](https://www.vantajs.com/)
- [Rendering Procedural Vortex in Glass Sphere (Codrops)](https://tympanus.net/codrops/2025/03/10/rendering-a-procedural-vortex-inside-a-glass-sphere-with-three-js-and-tsl/)

### Roundabout / Horizontal Scroll
- [Mastering Carousels with GSAP (Codrops 2025)](https://tympanus.net/codrops/2025/04/21/mastering-carousels-with-gsap-from-basics-to-advanced-animation/)
- [Horizontal Scroll with GSAP & ScrollTrigger (Envato Tuts+)](https://webdesign.tutsplus.com/create-horizontal-scroll-animations-with-gsap-scrolltrigger--cms-108881t)
- [GSAP Community: ScrollTrigger Rotate](https://gsap.com/community/forums/topic/33897-scrolltrigger-rotate-on-each-slide/)

### Center Hero Layout
- [Hero Section Design (Elegant Themes 2025)](https://www.elegantthemes.com/blog/design/how-to-design-a-hero-section)
- [Art of Hero Section (Orizon Design / Medium)](https://medium.com/orizon-design/the-art-of-the-hero-section-common-design-layouts-and-when-to-use-them-8fc176c93458)
- [Premium Hero Section Design for Brands (TYPZA)](https://www.typza.com/blog/website-hero-section-design-for-premium-brands)

### Libraries & CDN
- [GSAP on cdnjs](https://cdnjs.com/libraries/gsap)
- [Motion One](https://motion.dev)
- [Lenis GitHub](https://github.com/darkroomengineering/lenis)
- [3D Web Design in 2026 (Mivi)](https://mivibzzz.com/resources/web-development/3d-web-design-threejs-modern-libraries)

