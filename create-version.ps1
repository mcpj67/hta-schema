# create-version.ps1 - Create a new version tag for hta-schema

param(
    [Parameter(Mandatory=$false)]
    [string]$Version,
    
    [Parameter(Mandatory=$false)]
    [string]$Message
)

Write-Host "=== HTA Schema: Create New Version ===" -ForegroundColor Cyan

# Check if we're in a git repository
if (-not (Test-Path .git)) {
    Write-Host "ERROR: Not a git repository. Run this from hta-schema directory." -ForegroundColor Red
    exit 1
}

# Check for uncommitted changes
$status = git status --porcelain
if ($status) {
    Write-Host "ERROR: You have uncommitted changes. Commit or stash them first." -ForegroundColor Red
    git status --short
    exit 1
}

# Get version if not provided
if (-not $Version) {
    Write-Host ""
    Write-Host "Current tags:" -ForegroundColor Cyan
    git tag -l
    Write-Host ""
    $Version = Read-Host "Enter new version (e.g., v0.1.0)"
    if (-not $Version) {
        Write-Host "ERROR: Version required." -ForegroundColor Red
        exit 1
    }
}

# Ensure version starts with 'v'
if (-not $Version.StartsWith('v')) {
    $Version = "v$Version"
}

# Check if tag already exists
$existingTag = git tag -l $Version
if ($existingTag) {
    Write-Host "ERROR: Tag $Version already exists." -ForegroundColor Red
    exit 1
}

# Get message if not provided
if (-not $Message) {
    $Message = Read-Host "Enter release message (optional)"
    if (-not $Message) {
        $Message = "Release $Version"
    }
}

# Create annotated tag
Write-Host ""
Write-Host "Creating tag $Version..." -ForegroundColor Cyan
git tag -a $Version -m $Message

if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to create tag" -ForegroundColor Red
    exit 1
}

# Push tag to remote
Write-Host "Pushing tag to origin..." -ForegroundColor Cyan
git push origin $Version

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ Successfully created version $Version" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Go to GitHub → Releases → Draft a new release"
    Write-Host "2. Choose tag: $Version"
    Write-Host "3. Add release notes"
    Write-Host "4. Publish release"
} else {
    Write-Host "✗ Failed to push tag" -ForegroundColor Red
    Write-Host "Tag created locally but not pushed." -ForegroundColor Yellow
    exit 1
}
