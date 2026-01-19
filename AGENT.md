# Home Directory Context

Last updated: 2026-01-19

## Priority Focus

```
[ACTIVE]  furnisher    - AI furniture design, generates OpenSCAD from voice/text
[ACTIVE]  medina       - Media management with MCP, audio transcription pipeline
[DORMANT] taberna      - Copresence/audio recording app, PWA
[DEPLOYED] fallible.com - Personal blog archive 2000-2012, Eleventy + Cloudflare
[ARCHIVE] chillbo.club, align2, omnisite
```

---

## projects/

| Name | Status | Tech Stack | Git | Commits | Guidance |
|------|--------|------------|-----|---------|----------|
| furnisher | ACTIVE | Bun, React 19, AI SDK, OpenSCAD | No | - | AGENT.md |
| medina | ACTIVE | Bun, Hono, MCP, Podman workers | Yes | 27 | CLAUDE.md |
| taberna | DORMANT | Next.js 15, React 19, ElevenLabs | Yes | 46 | - |
| fallible.com | DEPLOYED | Eleventy, Cloudflare Workers | Yes | 15 | - |
| align2 | ARCHIVE | Node/Express, Sharp, FFmpeg | Yes | 73 | - |
| chillbo.club | ARCHIVE | Deno, Hono, ElevenLabs | Yes | 3 | - |
| omnisite | ARCHIVE | Bun, Hono, SQLite CMS | No | - | - |

### Project-specific guidance files
- `projects/furnisher/AGENT.md` - Stack preferences, vision
- `projects/medina/CLAUDE.md` - Bun conventions, ignore /backend and /web

---

## experiments/

### Keep
| Name | What | Notes |
|------|------|-------|
| happy | Home Assistant WebSocket integration | Functional HA client code |
| medina-new | React + Vite + CF Workers + audio processing | Most complete archived iteration |
| medina-less-old | CF Workers + Durable Objects + MCP | Simpler MCP server |
| medina-old | Next.js + Vercel MCP adapter | First iteration |

### Throwaway (safe to delete)
- `bsky-test` - Incomplete Bluesky post script
- `claude-test` - Hello World Hono server
- `greenbutton` - Empty PlatformIO blink example
- `gtts` - 3-line Google TTS test
- `taberna-persist` - Wrangler local persistence data, not code

### Medina evolution
```
medina-old (Next.js/Vercel) 
  -> medina-less-old (CF Workers/Durable Objects)
  -> medina-new (React+Vite+Workers, audio processing)
  -> projects/medina (canonical, Bun/Hono/Podman)
```

---

## Other Directories

| Path | What | Action |
|------|------|--------|
| webctl/ | Clone of cosinusalpha/webctl (browser automation) | Safe to delete if not using |
| TS_BoxBot/ | Clone of gever's ESP32 robot project | Safe to delete |
| to-transfer/ | 29GB of WAV audio files (lifelog Nov24-Mar25) | Back up then delete |
| minio/, minio-data/ | Local S3 dev storage | Keep if using for dev |
| minio-bin, minio.deb | MinIO binaries | Can delete, reinstall if needed |

---

## Cleanup TODOs

- [ ] `git init` in projects/furnisher
- [ ] `git init` in projects/omnisite (if keeping)
- [ ] Back up ~/to-transfer to permanent storage, then `rm -rf ~/to-transfer`
- [ ] Delete throwaway experiments: `rm -rf experiments/{bsky-test,claude-test,greenbutton,gtts,taberna-persist}`
- [ ] Delete cloned repos if not needed: `rm -rf ~/TS_BoxBot ~/webctl`
- [ ] Consider archiving experiments/medina-* once projects/medina is stable
- [ ] Clean up MinIO binaries: `rm ~/minio-bin ~/minio.deb`

---

## For AI Agents

### Before making changes
1. Check for `CLAUDE.md` or `AGENT.md` in the project directory
2. Look for `.claude/` directory for Claude-specific settings

### Stack conventions
- **Runtime**: Bun over Node.js for TypeScript projects
- **Web framework**: Hono (lightweight) or Next.js (full-stack)
- **Storage**: MinIO at localhost for S3-compatible dev storage
- **AI**: Vercel AI SDK with OpenAI, ElevenLabs for voice

### Common patterns across projects
- S3-compatible object storage for media/files
- Job queues for async processing (transcoding, transcription)
- MCP (Model Context Protocol) for agent integration
- Tailwind CSS for styling

### Task suggestion heuristic
To suggest actionable tasks: Prioritize the most-active project from 'Priority Focus', review its TODOs in the 'projects/' section, and propose items from there.
