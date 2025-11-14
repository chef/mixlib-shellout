# GitHub Copilot Instructions for mixlib-shellout

## Repository Overview

**mixlib-shellout** is a Ruby library that provides a simplified interface to shelling out while collecting both standard out and standard error, and providing full control over environment, working directory, uid, gid, etc. It's part of the Chef ecosystem and provides cross-platform command execution capabilities.

## Repository Structure

```
mixlib-shellout/
├── .expeditor/                    # Expeditor CI/CD configuration
│   ├── config.yml                # Main Expeditor configuration
│   ├── verify.pipeline.yml       # Build pipeline definition
│   ├── run_linux_tests.sh        # Linux test runner
│   ├── run_windows_tests.ps1     # Windows test runner
│   └── update_version.sh         # Version update script
├── .github/
│   ├── CODEOWNERS               # Code ownership definitions
│   ├── ISSUE_TEMPLATE/          # Issue templates
│   ├── workflows/               # GitHub Actions workflows
│   │   └── ci-main-pull-request-checks.yml
│   └── copilot-instructions.md  # This file
├── lib/mixlib/
│   ├── shellout.rb             # Main ShellOut class
│   └── shellout/
│       ├── exceptions.rb       # Custom exceptions
│       ├── helper.rb          # Helper utilities
│       ├── unix.rb           # Unix-specific implementation
│       ├── version.rb        # Version information
│       ├── windows.rb        # Windows-specific implementation
│       └── windows/
│           └── core_ext.rb   # Windows core extensions
├── spec/                      # Test suite
│   ├── spec_helper.rb        # RSpec configuration
│   ├── mixlib/
│   │   ├── shellout_spec.rb  # Main test file
│   │   └── shellout/
│   │       ├── helper_spec.rb    # Helper tests
│   │       └── windows_spec.rb   # Windows-specific tests
│   └── support/              # Test support files
├── vendor/bundle/            # Bundled gems (gitignored in production)
├── Gemfile                   # Ruby dependencies
├── Rakefile                  # Build tasks
├── mixlib-shellout.gemspec   # Gem specification
├── VERSION                   # Version file
├── README.md                 # Project documentation
├── CHANGELOG.md              # Change history
├── CONTRIBUTING.md           # Contribution guidelines
├── CODE_OF_CONDUCT.md        # Code of conduct
└── LICENSE                   # Apache 2.0 license
```

## Jira Integration Workflow

When a Jira ID is provided:

1. **Use the Atlassian MCP Server** to fetch issue details:
   ```bash
   # The atlassian-mcp-server should be configured and available
   # Use the MCP tools to fetch Jira issue information
   ```

2. **Read and analyze the Jira story** to understand:
   - Requirements and acceptance criteria
   - Technical specifications
   - Expected behavior changes
   - Impact on existing functionality

3. **Implement the task** following the story requirements:
   - Make necessary code changes in `lib/mixlib/shellout/` 
   - Ensure cross-platform compatibility (Unix/Windows)
   - Follow existing code patterns and style

## Testing Requirements

### Coverage Standards
- **Maintain > 80% test coverage** at all times
- Run coverage reports using: `bundle exec rspec --format documentation`
- All new features must include comprehensive test cases

### Test Structure
- **Unit tests**: Place in `spec/mixlib/shellout_spec.rb` or appropriate subdirectory
- **Platform-specific tests**: Use `spec/mixlib/shellout/windows_spec.rb` for Windows-only features
- **Helper tests**: Place helper function tests in `spec/mixlib/shellout/helper_spec.rb`

### Test Categories
Use RSpec filters appropriately:
- `:windows_only` - Windows-specific functionality
- `:unix_only` - Unix/Linux-specific functionality  
- `:linux_only` - Linux-specific functionality
- `:requires_root` - Tests requiring root privileges
- `:external` - Tests requiring external dependencies

### Running Tests
```bash
# Run all tests
bundle exec rake spec

# Run specific platform tests
bundle exec rspec --tag unix_only
bundle exec rspec --tag windows_only

# Run with coverage
bundle exec rspec --format documentation
```

## DCO Compliance Requirements

All commits must include a **Developer Certificate of Origin (DCO) sign-off**:

```bash
git commit -s -m "Your commit message"

# Or add manually to commit message:
Signed-off-by: Your Name <your.email@example.com>
```

**DCO Requirements:**
- Every commit must be signed off
- Use your real name (no pseudonyms)
- Use your actual email address
- Indicates you have the right to contribute the code
- Confirms you agree to the DCO terms

## Build System Integration

### Expeditor Configuration
The repository uses **Expeditor** for automated CI/CD:

- **Main config**: `.expeditor/config.yml`
- **Build pipeline**: `.expeditor/verify.pipeline.yml`
- **Notifications**: Sent to `#chef-found-notify` Slack channel
- **Auto-versioning**: Supports major/minor version bumps via labels

### GitHub Actions
- **Workflow**: `.github/workflows/ci-main-pull-request-checks.yml`
- **Triggers**: Pull requests and pushes to `main` and `release/**` branches
- **Features**: Complexity checks, TruffleHog scanning, SBOM generation

### Available Build Commands
```bash
# Run tests locally
bundle exec rake spec

# Generate documentation  
bundle exec rake rdoc

# Build gem
gem build mixlib-shellout.gemspec

# Install locally for testing
gem install ./mixlib-shellout-*.gem
```

## GitHub Labels

### Aspect Labels
- `Aspect: Documentation` - Documentation improvements
- `Aspect: Integration` - Integration with other systems
- `Aspect: Packaging` - Distribution and packaging
- `Aspect: Performance` - Performance optimizations  
- `Aspect: Portability` - Cross-platform compatibility
- `Aspect: Security` - Security-related changes
- `Aspect: Stability` - Stability improvements
- `Aspect: Testing` - Test improvements and CI
- `Aspect: UI` - User interface changes
- `Aspect: UX` - User experience improvements

### Expeditor Labels  
- `Expeditor: Bump Version Major` - Triggers major version bump
- `Expeditor: Bump Version Minor` - Triggers minor version bump
- `Expeditor: Skip All` - Skips all merge actions
- `Expeditor: Skip Changelog` - Skips changelog updates
- `Expeditor: Skip Habitat` - Skips Habitat package builds
- `Expeditor: Skip Omnibus` - Skips Omnibus builds
- `Expeditor: Skip Version Bump` - Skips version bumping

### Platform Labels
- `Platform: AWS`, `Platform: Azure`, `Platform: GCP` - Cloud platforms
- `Platform: Docker` - Container-related changes
- `Platform: Linux`, `Platform: macOS` - OS-specific changes
- `Platform: Debian-like`, `Platform: RHEL-like`, `Platform: SLES-like` - Linux distributions
- `Platform: Unix-like`, `Platform: VMware` - Platform-specific changes

### Other Labels
- `hacktoberfest-accepted` - Accepted Hacktoberfest contributions
- `oss-standards` - OSS repository standardization

## Pull Request Creation Workflow

### Branch Naming
- **Use Jira ID as branch name** (e.g., `COOK-1234` or `CHEF-5678`)
- For non-Jira work: Use descriptive names (e.g., `fix-windows-timeout`, `improve-error-handling`)

### PR Creation Process

1. **Create and switch to feature branch**:
   ```bash
   git checkout -b JIRA-ID
   # Example: git checkout -b CHEF-1234
   ```

2. **Make changes and commit with DCO**:
   ```bash
   # Make your changes
   git add .
   git commit -s -m "Fix shellout timeout handling on Windows
   
   - Improved error detection for timeout scenarios
   - Added proper cleanup for hung processes
   - Updated Windows-specific error messages
   
   Fixes CHEF-1234"
   ```

3. **Push branch and create PR using GitHub CLI**:
   ```bash
   # Push the branch
   git push origin JIRA-ID
   
   # Create PR with proper description
   gh pr create --title "JIRA-ID: Brief description" --body "$(cat <<EOF
   <h2>Summary</h2>
   <p>Brief description of changes made</p>
   
   <h2>Changes Made</h2>
   <ul>
   <li>Specific change 1</li>
   <li>Specific change 2</li>
   <li>Specific change 3</li>
   </ul>
   
   <h2>Testing</h2>
   <ul>
   <li>Added unit tests for new functionality</li>
   <li>Verified cross-platform compatibility</li>
   <li>Confirmed coverage remains > 80%</li>
   </ul>
   
   <h2>Jira Issue</h2>
   <p>Resolves: <a href="https://tickets.chef.io/browse/JIRA-ID">JIRA-ID</a></p>
   
   <h2>DCO</h2>
   <p>All commits are signed off as required by the DCO.</p>
   EOF
   )"
   ```

### PR Guidelines
- **Title format**: `JIRA-ID: Brief descriptive title`
- **Description**: Use HTML formatting for better readability
- **Include**: Summary, detailed changes, testing notes, Jira link
- **Labels**: Apply appropriate aspect and platform labels
- **Reviews**: Request reviews from code owners (see `CODEOWNERS`)

## Complete Development Workflow

### 1. Task Analysis Phase
```markdown
**PROMPT FOR USER**: "I've received the task. Let me analyze the Jira issue and repository structure. 

Next steps:
- [ ] Fetch Jira issue details using MCP server
- [ ] Analyze requirements and acceptance criteria  
- [ ] Identify files that need modification
- [ ] Plan implementation approach

Would you like me to continue with fetching the Jira details?"
```

### 2. Planning Phase  
```markdown
**PROMPT FOR USER**: "Based on the Jira analysis, here's my implementation plan:

Summary: [Brief description of what needs to be done]

Implementation Plan:
- [ ] Modify [specific files]
- [ ] Add [new functionality]  
- [ ] Update [existing behavior]
- [ ] Create comprehensive tests
- [ ] Verify cross-platform compatibility

Next step: Begin implementation starting with [specific task]

Remaining steps: [List remaining tasks]

Should I proceed with the implementation?"
```

### 3. Implementation Phase
For each major change:
```markdown
**PROMPT FOR USER**: "I've completed [specific task]. 

What I did:
- [Specific changes made]
- [Files modified]
- [New functionality added]

Next step: [Next specific task]
Remaining steps: [Updated list of remaining tasks]

Current progress: [X of Y tasks completed]

Should I continue with [next step]?"
```

### 4. Testing Phase
```markdown
**PROMPT FOR USER**: "Implementation complete. Now running comprehensive tests:

Testing checklist:
- [ ] Unit tests for new functionality
- [ ] Cross-platform compatibility tests
- [ ] Regression tests for existing functionality  
- [ ] Code coverage verification (target: >80%)

Next step: Create unit tests and verify coverage

Should I proceed with the testing phase?"
```

### 5. PR Preparation Phase
```markdown  
**PROMPT FOR USER**: "All tests passing with coverage at [X]%. Ready for PR creation:

PR Summary:
- Branch: [JIRA-ID]
- Files changed: [list]
- Test coverage: [percentage]
- All commits signed off (DCO compliant)

Next step: Create branch, push changes, and submit PR

Should I proceed with creating the pull request?"
```

### 6. Completion Phase
```markdown
**PROMPT FOR USER**: "Task completed successfully! 

Summary:
✅ Jira issue [ID] implemented  
✅ Tests created with [X]% coverage
✅ Cross-platform compatibility verified
✅ PR created: [PR link]
✅ DCO compliance confirmed

The PR is ready for review. No further action needed unless review feedback is received.

Is there anything else you'd like me to explain about the implementation?"
```

## Workflow Rules and Guidelines

### File Modification Restrictions
- **Never modify**: 
  - `.expeditor/config.yml` (without explicit approval)
  - Version files (handled automatically by Expeditor)
  - License files
  - GitHub workflow files (without security review)

### Code Style Guidelines
- Follow existing Ruby style conventions in the codebase
- Use 2-space indentation
- Keep method complexity low
- Add comprehensive documentation for public APIs
- Follow the existing error handling patterns

### Cross-Platform Considerations
- Always consider Windows and Unix implementations
- Use platform-specific modules when necessary (`unix.rb`, `windows.rb`)
- Test platform-specific code paths
- Handle platform differences gracefully

### Security Considerations
- Validate all external inputs
- Properly escape shell commands
- Handle file permissions correctly
- Follow secure coding practices for shell execution

## Prompt-Based Development Guidelines

### After Each Step
Always provide a summary and ask for continuation:
```markdown
**Step Summary**: [What was accomplished]  
**Next Step**: [What comes next]
**Remaining Steps**: [What's left to do]
**Continue?**: Should I proceed with [next step]?
```

### Decision Points
When encountering ambiguity:
```markdown  
**Decision Needed**: [Description of the decision point]
**Options**: 
1. [Option 1 with pros/cons]
2. [Option 2 with pros/cons]

**Recommendation**: [Your recommendation with reasoning]
**Should I proceed with the recommended approach?**
```

### Error Handling
When encountering issues:
```markdown
**Issue Encountered**: [Description of the problem]
**Attempted Solutions**: [What was tried]  
**Proposed Resolution**: [How to fix it]
**Impact**: [How this affects the overall task]

**Should I proceed with the proposed resolution?**
```

## MCP Server Integration

### Atlassian MCP Server Usage
The repository is configured to use the `atlassian-mcp-server` for Jira integration:

1. **Fetch Issue Details**:
   ```javascript
   // Use MCP tools to get Jira issue information
   // Example: mcp_atlassian-mcp_getJiraIssue
   ```

2. **Issue Analysis**:
   - Extract requirements from issue description
   - Identify acceptance criteria  
   - Understand technical specifications
   - Note any dependencies or blockers

3. **Progress Updates**:
   - Update Jira issue with progress comments
   - Link commits and PR to the issue
   - Update issue status as appropriate

### Available MCP Tools
- `mcp_atlassian-mcp_getJiraIssue` - Get issue details
- `mcp_atlassian-mcp_addCommentToJiraIssue` - Add progress comments
- `mcp_atlassian-mcp_transitionJiraIssue` - Update issue status
- `mcp_atlassian-mcp_search` - Search for related issues

Remember to use these tools to maintain traceability between code changes and Jira issues throughout the development process.

## AI-Assisted Development & Compliance

- ✅ Create PR with `ai-assisted` label (if label doesn't exist, create it with description "Work completed with AI assistance following Progress AI policies" and color "9A4DFF")
- ✅ Include "This work was completed with AI assistance following Progress AI policies" in PR description

### Jira Ticket Updates (MANDATORY)

- ✅ **IMMEDIATELY after PR creation**: Update Jira ticket custom field `customfield_11170` ("Does this Work Include AI Assisted Code?") to "Yes"
- ✅ Use atlassian-mcp tools to update the Jira field programmatically
- ✅ **CRITICAL**: Use correct field format: `{"customfield_11170": {"value": "Yes"}}`
- ✅ Verify the field update was successful

### Documentation Requirements

- ✅ Reference AI assistance in commit messages where appropriate
- ✅ Document any AI-generated code patterns or approaches in PR description
- ✅ Maintain transparency about which parts were AI-assisted vs manual implementation

### Workflow Integration

This AI compliance checklist should be integrated into the main development workflow Step 4 (Pull Request Creation):

```
Step 4: Pull Request Creation & AI Compliance
- Step 4.1: Create branch and commit changes WITH SIGNED-OFF COMMITS
- Step 4.2: Push changes to remote
- Step 4.3: Create PR with ai-assisted label
- Step 4.4: IMMEDIATELY update Jira customfield_11170 to "Yes"
- Step 4.5: Verify both PR labels and Jira field are properly set
- Step 4.6: Provide complete summary including AI compliance confirmation
```

- **Never skip Jira field updates** - This is required for Progress AI governance
- **Always verify updates succeeded** - Check response from atlassian-mcp tools
- **Treat as atomic operation** - PR creation and Jira updates should happen together
- **Double-check before final summary** - Confirm all AI compliance items are completed

### Audit Trail

All AI-assisted work must be traceable through:

1. GitHub PR labels (`ai-assisted`)
2. Jira custom field (`customfield_11170` = "Yes")
3. PR descriptions mentioning AI assistance
4. Commit messages where relevant
