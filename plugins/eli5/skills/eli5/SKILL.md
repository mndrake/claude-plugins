---
name: eli5
description: Explain a topic like I'm a 5 year old. Use when the user types /eli5 <topic>, says "ELI5" or "explain like I'm five", or asks for a dead-simple picture explainer of how something works.
---

# eli5

Explain like I'm someone who knows nothing about this topic, using a HTML artifact with big pictures and few words.

Topic: $ARGUMENTS

If the topic above is empty or still reads as a literal placeholder, the topic is whatever the user asked to have explained in their message.

## How to explain

- Pictures do the work. Every idea gets a big, simple visual (inline SVG shapes, emoji, arrows, boxes) — not a paragraph.
- Very few words. Short sentences a 5 year old could follow. No jargon; if a real term is unavoidable, show what it means with a picture first.
- Use one everyday analogy (mail, kitchens, toys, roads) and stick with it the whole way through.
- Tell it as a short story in 3–6 steps, top to bottom: what the thing is, what goes in, what happens, what comes out.
- End with a single one-line "the big idea" summary.

## How to build the page

- One self-contained HTML file: inline CSS and inline SVG, no external images, fonts, or scripts required.
- Large type, lots of whitespace, bright friendly colors with good contrast, readable on a phone.

## Where to put it

Deliver it the way the current app shows HTML best:

- **Claude chat (claude.ai, desktop, mobile):** create an HTML artifact so it renders next to the conversation.
- **Claude Cowork:** save it as an `.html` file in the working folder (for example `eli5-<topic>.html`) and share or open it for the user.
- **Claude Code:** write it to an `.html` file in the current directory (for example `eli5-<topic>.html`), or publish it as an artifact if an artifact tool is available, and tell the user where it is.

Keep any message around the explainer to one or two sentences — the page is the answer.
