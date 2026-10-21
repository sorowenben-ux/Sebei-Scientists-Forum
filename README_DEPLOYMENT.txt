# Sebei Scientists Forum website — deployment guide

## What's included
- `index.html` — redesigned responsive website based on the Sebei Scientists Forum Constitution (8 July 2022).
- `supabase_setup.sql` — database table and Row Level Security policy for online membership applications.
- `sebei_scientists_forum_constitution.pdf` — the Constitution linked from the website.
- `privacy.html` — starter privacy notice; the Forum must complete and approve the missing operational details before launch.

## Important: online storage needs a one-time setup
The website is a static GitHub Pages site. GitHub Pages does not itself provide a database, so this version uses Supabase for online storage. The form will clearly report that storage is not configured until you complete the steps below. Do not publish it as a working online application form before setup is complete.

### 1. Create the database
1. Sign in to https://supabase.com/ and create a project.
2. Open **SQL Editor** in the Supabase project.
3. Open `supabase_setup.sql`, copy all of it into a new SQL query, and run it.
4. Confirm that the `membership_applications` table exists in **Table Editor**.

### 2. Connect the website
1. In Supabase, open **Project Settings → API** (or the project's API/connect settings).
2. Copy the Project URL and the publishable/anon key.
3. In `index.html`, find:
   - `const SUPABASE_URL = "YOUR_SUPABASE_PROJECT_URL";`
   - `const SUPABASE_ANON_KEY = "YOUR_SUPABASE_PUBLISHABLE_OR_ANON_KEY";`
4. Replace the placeholders with your Project URL and **publishable/anon** key.
5. Never put a `service_role` key or any secret key in `index.html`. The website is public.
6. Test a sample application and check that it appears in Supabase **Table Editor → membership_applications**.

### 3. Publish on GitHub Pages
1. In your repository, upload `index.html` to the repository root.
2. Ensure the file is named exactly `index.html`.
3. Commit the file to the branch selected under **Settings → Pages** (usually `main`, folder `/(root)`).
6. Upload `supabase_setup.sql` too if you want to keep the database setup instructions in the repository; it is not required by the live website.
7. Wait for GitHub Pages deployment to finish, then test the live membership form.

## How applications are protected
- Public visitors can insert applications only.
- Public visitors cannot list/read applications, update statuses, or delete records through the website.
- New records default to `pending`; only the Forum's authorized database administrators should review the register and update application statuses.
- Review applications in Supabase Dashboard while signed in. Do not create a public admin page or expose a service-role key.

## Global-standard improvements included
- Clear membership categories and an explicit note that application submission is not automatic admission.
- A direct link to the actual Constitution rather than a placeholder external link.
- Responsive layout, skip-to-content navigation, keyboard focus styles, reduced-motion support, and labelled form fields. These are useful accessibility foundations, not a certification of WCAG conformance; test the live site with keyboard and assistive technology.
- Basic search/social metadata and a standalone privacy notice. The privacy notice intentionally flags decisions the Forum must make rather than inventing a retention period or claiming legal compliance.
- Database Row Level Security: public users may submit but cannot read the register through the public website.

## Before using with real applicants
- Restrict Supabase project/dashboard access to trusted Forum administrators and enable strong account security.
- Add CAPTCHA/anti-spam and server-side rate limiting before broadly publicizing the form. The current public insert policy is a starter design and can be abused by bots; a production deployment should add a server-side validation/anti-abuse layer.
- Complete and approve `privacy.html`: name the responsible data controller/contact, define a retention period, and establish request, correction, deletion and complaint procedures. Confirm the arrangements meet Uganda’s applicable data-protection requirements before launch.
- Collect only information the Forum needs, and handle the register in accordance with applicable privacy and data-protection obligations.
- The constitution describes membership approval by the Council; submitting the online form is an application, not automatic admission.

## Content notes
The site reflects the constitution's stated aim, mission, vision, motto, membership classes and selected objectives. Honorary membership is described separately because the constitution provides for nomination and approval rather than a routine public application form. Please verify any changes to official contact details, office holders, and event announcements before publishing.


PROJECT-SPECIFIC CONFIGURATION UPDATE (21 October 2026)
======================================================
The website is now preconfigured with the Supabase Project URL for project ref:
evcxtordemhrrxdkvvpj
Project URL: https://evcxtordemhrrxdkvvpj.supabase.co
Dashboard: https://supabase.com/dashboard/project/evcxtordemhrrxdkvvpj?showConnect=true

IMPORTANT: The public publishable key cannot be obtained from the dashboard URL alone.
Sign in to the dashboard, open Connect or Settings > API Keys, and copy the project's
publishable key (usually begins sb_publishable_). In index.html, replace:
PASTE_YOUR_SUPABASE_PUBLISHABLE_KEY_HERE
with the real publishable key. Never use a secret or service_role key in index.html.

Then open SQL Editor in the same project and run supabase_setup.sql. Check Table Editor
for public.membership_applications, then upload the updated index.html to your hosting.
Test a submission and verify the row appears in Table Editor before announcing the form.
The site has not been connected to a live database until the key is added and the SQL is run.
