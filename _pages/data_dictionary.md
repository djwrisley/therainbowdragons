---
title: "Data Dictionary"
layout: single
permalink: /data-dictionary/
author_profile: false
---


The collection of Doors was manually annotated on 5 categories. Four of
the categories are simple Yes/No binaries — Open/Closed, Round-Top/Flat-Top,
Graffiti/No-Graffiti, and Sticker-Signage/No-Sticker-Signage. The fifth,
Color, was a selection from a limited number of options. The rationale for
each annotation is below.

| Category | Values | Rationale |
|---|---|---|
| **Open/Closed** | Open · Closed | A door was marked **Open** if you could see through to the other side of the frame. Doors that were visibly unlocked or slightly ajar were still marked **Closed**. |
| **Round-Top/Flat-Top** | Round-Top · Flat-Top | Refers to the geometry of the door's *frame* — the architectural elements directly surrounding the door, not just the structure holding it in place. Where the frame was discontinuous, the top-most part was used. A rectangular frame top was marked **Flat-Top**; anything else was marked **Round-Top**. |
| **Graffiti/No-Graffiti** | Graffiti · No-Graffiti | Marks whether a door contains clandestine writing or images. Worn paint or staining alone did not count — those doors were still marked **No-Graffiti**. |
| **Sticker-Signage/No-Sticker-Signage** | Sticker-Signage · No-Sticker-Signage | Marks whether the door itself carries any stickers or signage (writing counted as signage). Signage on the door's *outer frame* was not counted. |
| **Color** | Blue · Red · Green · Brown · Black · Gray · Other | An approximation of the door's color. Each door was annotated with the closest matching option — e.g. a turquoise door was marked **Green**. Doors with no close match were marked **Other** — e.g. a purple door. |

_Add example photos under the Round-Top/Flat-Top and Sticker-Signage rows
once you have them — swap the note for an inline image, e.g.:_

```markdown
![Example of a round-top frame](/therainbowdragons/assets/images/example-roundtop.jpg)
```