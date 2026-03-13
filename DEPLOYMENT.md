# Castalia Marketing Slides Deployment

## Prerequisites

1. **GitHub Repository**: `InquiryInstitute/castalia-marketing-slides` ✓ (Created)
2. **Supabase Project**: https://supabase.com
3. **AWS Account**: For Route 53 domain management
4. **Google Cloud Console**: For OAuth credentials

## Step 1: GitHub Repository ✓

Repository created: https://github.com/InquiryInstitute/castalia-marketing-slides

## Step 2: GitHub Pages Configuration

GitHub Pages is now enabled at:
- **URL**: https://inquiryinstitute.github.io/castalia-marketing-slides/

## Step 3: Configure Supabase

1. Go to [Supabase](https://supabase.com) and create a project
2. Go to **Authentication** → **Providers** → **Google**
3. Enable Google and add OAuth credentials:
   - Get credentials from [Google Cloud Console](https://console.cloud.google.com/)
   - Add redirect URI: `https://martech.castalia.institute`
4. Copy your credentials:
   - Project URL: `https://your-project.supabase.co`
   - anon key: `eyJhbGciOiJIUzI1NiIs...`

## Step 4: Set GitHub Secrets

In your GitHub repository, go to **Settings** → **Secrets and variables** → **Actions**:

1. **SUPABASE_URL**: Your Supabase project URL
2. **SUPABASE_ANON_KEY**: Your Supabase anon key

## Step 5: Configure Route 53 (AWS)

### Option A: Using CloudFormation (Recommended)

```bash
# Deploy Route 53 stack
aws cloudformation deploy \
  --template-file route53-stack.yml \
  --stack-name castalia-marketing-route53 \
  --parameter-overrides \
    HostedZoneName=castalia.institute \
    DomainName=martech.castalia.institute \
    GitHubPagesEmail=your-email@example.com \
  --capabilities CAPABILITY_NAMED_IAM
```

### Option B: Manual Route 53 Setup

1. Go to [Route 53 Console](https://console.aws.amazon.com/route53/)
2. Create hosted zone: `castalia.institute`
3. Create DNS records:
   - **A Record**: `martech.castalia.institute` → GitHub Pages IPs
     - 185.199.108.153
     - 185.199.109.153
     - 185.199.110.153
     - 185.199.111.153
   - **CNAME**: `www.martech.castalia.institute` → `martech.castalia.institute`

### Option C: Direct GitHub Pages Domain

1. Go to repository **Settings** → **Pages**
2. Under **Custom domain**:
   - Domain: `martech.castalia.institute`
   - Click **Save**
3. GitHub will provide DNS records to add in Route 53

## Step 6: Deploy to GitHub Pages

```bash
# Push to main branch
git push -u origin main

# Or trigger manually via GitHub Actions
# Go to Actions tab → Deploy Marketing Slides → Run workflow
```

## Step 7: Verify Deployment

1. Check GitHub Pages URL: https://inquiryinstitute.github.io/castalia-marketing-slides/
2. Test custom domain: https://martech.castalia.institute
3. Test Google authentication flow

## Troubleshooting

### GitHub Pages Not Loading
- Check repository Settings → Pages for errors
- Verify branch is set to `main` and folder is `/`

### Supabase Auth Not Working
- Verify redirect URIs in Supabase match your domain
- Check browser console for CORS errors
- Ensure Supabase project is active

### Route 53 DNS Not Propagating
- Wait 5-10 minutes for DNS propagation
- Check DNS records in Route 53 console
- Verify SSL certificate status in ACM

## Files Structure

```
martech/
├── .github/workflows/deploy.yml    # GitHub Actions workflow
├── frontend/                        # Vue.js frontend
│   ├── src/
│   │   ├── App.vue                  # Main app component
│   │   ├── main.ts                  # Entry point
│   │   └── assets/
│   │       └── slide-theme.css      # Custom slide styles
│   ├── index.html                   # HTML template
│   ├── package.json                 # Dependencies
│   └── vite.config.ts               # Vite configuration
├── castalia-marketing-deck.md      # Slide content
├── route53-stack.yml               # AWS CloudFormation template
└── DEPLOYMENT.md                    # This file
```

## Cost Estimate

- **GitHub Pages**: Free
- **Supabase**: Free tier (up to 50K MAU)
- **Route 53**: $0.50/month (hosted zone)
- **AWS ACM**: Free (SSL certificates)

## Next Steps

1. ✓ Create GitHub repository
2. Set up Supabase project
3. Configure GitHub secrets
4. Deploy Route 53 DNS (using CloudFormation or manual)
5. Push code and deploy
