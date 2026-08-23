# Security Model

## Personas

### Student
Can access their own profile, eligible jobs, and own applications.

### Placement Officer
Can manage jobs, applications, and placement workflows.

### Recruiter
Can access authorised candidate information and permitted interview data.

### Administrator
Has broader administrative capability.

## Security Layers

The application uses multiple security layers:

```text
User
 ↓
Authentication
 ↓
Object Access
 ↓
Field Security
 ↓
Record Sharing
 ↓
Apex Sharing Behaviour
 ↓
Effective Access
