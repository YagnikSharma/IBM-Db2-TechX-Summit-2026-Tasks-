# IBM Db2 TechX Summit 2026 — Interactive Checklist

A static, responsive HTML checklist for event operations. No framework, package install, server or database is required.

## Features

- Quick checklist at the top, with detailed tasks and owners below.
- Checkboxes are synchronized between the quick checklist and task details.
- Progress counter and progress bar.
- Checkmarks persist in the same browser using `localStorage`.
- Search, expand/collapse, reset, export progress as JSON, and print the quick checklist.
- Event, GitHub and guest LinkedIn links included.

## Run locally

Open `index.html` in a modern browser. For hosting, deploy this folder as a static site.

## Deploy on Vercel

### Dashboard + GitHub

1. Create a new GitHub repository and upload `index.html`, `vercel.json`, and `README.md` from this folder.
2. Sign in at https://vercel.com and select **Add New → Project**.
3. Import the GitHub repository.
4. Select **Other** as the framework preset. Leave the build command blank; use `.` as the output directory if Vercel requests one.
5. Select **Deploy**. Vercel will provide the live `.vercel.app` URL.

Vercel's official documentation confirms that plain HTML/CSS/JS projects can skip the build step: https://vercel.com/docs/builds

### Or deploy with Vercel CLI

Install Node.js if it is not installed, then run from this folder:

```bash
npm install -g vercel
vercel
```

Follow the prompts to sign in and create a preview deployment. To publish to production after checking the preview, run:

```bash
vercel --prod
```

## Important checkbox behaviour

Progress is saved locally in each browser/device. It is **not shared or synchronized** between different coordinators. Use **Export progress** to save a JSON backup. Shared multi-user progress would need a database/backend and appropriate access control.
