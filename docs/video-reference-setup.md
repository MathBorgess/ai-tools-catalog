# Set up video-reference for Remotion

The [video-reference CLI](../video-reference/README.md) stores local reference libraries and creates direction packets. Its [companion skill](../skills-catalog/skills/creativity/video-reference/SKILL.md) guides the agent's audiovisual analysis. The production agent builds and edits a Remotion composition from that direction.

## Prepare the checkout and skill

From the catalog root:

```bash
./setup.sh
node video-reference/bin/video-reference.mjs --help
node video-reference/bin/video-reference.mjs doctor
```

The CLI requires Node.js 22+. Media ingestion and inspection require FFmpeg and FFprobe; `doctor` reports readiness without installing them. A global npm installation is optional; the direct Node command works from this checkout. Follow the CLI's README for its supported installation routes. Do not assume an unscoped npm package named `video-reference` belongs to this project.

Install the companion skill through the catalog's [normal agent setup](../README.md#install-in-your-agent). For the skills.sh route, a single-skill install is:

```bash
npx skills add MathBorgess/skills-catalog --skill video-reference
```

Choose the target agent in the installer. Preserve existing installations and use one route per agent: managed plugin or copied skills. Verify that the agent discovers `video-reference`; merely reading its file is not proof of installation.

The Remotion project has its own dependencies. The production agent follows that project's setup and the [Remotion handoff contract](../video-reference/docs/remotion.md). This wrapper does not install Node packages, FFmpeg, skills, models or renderers, and it does not alter agent settings.

## Start with an editable first pass

Ask the agent to use the selected reference and project context to:

1. Write `REVIEW.md` with a second-by-second plan: the hook in seconds 0–3, captions, visual elements and timing between image and sound.
2. Build the complete editable Remotion composition, retaining reference and authorship information. Use a 1080 × 1920 canvas, Instagram safe areas and unchanged source colors; do not introduce color correction.
3. Open Remotion Studio. The human reviews the full first pass and directs subsequent adjustments with the agent's help.

Media transcoding, transcription and preliminary cuts are not mandatory stages. Use them only when the task needs them, and never convert footage automatically. If the pipeline cannot preserve source color, report that constraint instead of silently converting it. Missing audio or timing evidence remains unknown; an editable composition does not prove audiovisual fidelity.

## Reuse a local reference library

Keep each reference project in its own folder outside these public source repositories. Follow the CLI's help and schemas to ingest, inspect, save, search or read a reference. When an analyzed reference is ready for production, request a Remotion packet:

```bash
node video-reference/bin/video-reference.mjs handoff <reference-id> --target remotion --project /path/to/reference-project
```

The handoff contains `DIRECTION.md` and `packet.json`; it is direction for the production agent, not a rendered video or an executable composition. Read the [handoff contract](../video-reference/docs/remotion.md) for connected layers, adaptations and human decisions. Preserve the project folder together with its evidence and media when moving it.

A text snapshot can help an agent recover descriptions, but it is not a media-complete library. Use available local tools when deeper audio or motion analysis is required, reuse installed models where possible, and report missing dependencies before installation. The [local-analysis guide](../video-reference/docs/local-analysis.md) describes these limits.

Report checkout readiness, skill discovery, CLI readiness, Remotion Studio readiness and reviewed audiovisual fidelity separately.
