using System;
using System.Security.Cryptography;
using System.Web;

namespace JanVoice.Helpers
{
    public static class AuthenticationHelper
    {
        // ============================================
        // ROLE IDs
        // ============================================

        public const int CitizenRole = 1;
        public const int OfficerRole = 2;
        public const int AdminRole = 3;


        // ============================================
        // CHECK LOGIN
        // ============================================

        public static bool IsLoggedIn()
        {
            return HttpContext.Current.Session["UserID"] != null;
        }


        // ============================================
        // GET CURRENT USER ID
        // ============================================

        public static int GetUserID()
        {
            if (!IsLoggedIn())
                return 0;

            return Convert.ToInt32(
                HttpContext.Current.Session["UserID"]
            );
        }


        // ============================================
        // GET CURRENT ROLE ID
        // ============================================

        public static int GetRoleID()
        {
            if (!IsLoggedIn())
                return 0;

            return Convert.ToInt32(
                HttpContext.Current.Session["RoleID"]
            );
        }


        // ============================================
        // CHECK ADMIN
        // ============================================

        public static bool IsAdmin()
        {
            return IsLoggedIn() &&
                   GetRoleID() == AdminRole;
        }


        // ============================================
        // CHECK OFFICER
        // ============================================

        public static bool IsOfficer()
        {
            return IsLoggedIn() &&
                   GetRoleID() == OfficerRole;
        }


        // ============================================
        // CHECK CITIZEN
        // ============================================

        public static bool IsCitizen()
        {
            return IsLoggedIn() &&
                   GetRoleID() == CitizenRole;
        }


        // ============================================
        // CREATE PASSWORD HASH
        // ============================================

        public static string HashPassword(string password)
        {
            if (string.IsNullOrEmpty(password))
                return string.Empty;

            // Generate unique random salt
            byte[] salt = new byte[16];

            using (RandomNumberGenerator rng =
                   RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            // PBKDF2
            using (Rfc2898DeriveBytes pbkdf2 =
                   new Rfc2898DeriveBytes(
                       password,
                       salt,
                       100000,
                       HashAlgorithmName.SHA256))
            {
                byte[] hash = pbkdf2.GetBytes(32);

                // Store:
                // salt + hash
                return Convert.ToBase64String(salt)
                       + ":"
                       + Convert.ToBase64String(hash);
            }
        }


        // ============================================
        // VERIFY PASSWORD
        // ============================================

        public static bool VerifyPassword(
            string password,
            string storedHash)
        {
            if (string.IsNullOrEmpty(password) ||
                string.IsNullOrEmpty(storedHash))
            {
                return false;
            }

            string[] parts =
                storedHash.Split(':');

            if (parts.Length != 2)
                return false;

            byte[] salt =
                Convert.FromBase64String(parts[0]);

            byte[] originalHash =
                Convert.FromBase64String(parts[1]);


            using (Rfc2898DeriveBytes pbkdf2 =
                   new Rfc2898DeriveBytes(
                       password,
                       salt,
                       100000,
                       HashAlgorithmName.SHA256))
            {
                byte[] newHash =
                    pbkdf2.GetBytes(32);

                return CompareBytes(
                    originalHash,
                    newHash
                );
            }
        }


        // ============================================
        // SECURE BYTE COMPARISON
        // ============================================

        private static bool CompareBytes(
            byte[] a,
            byte[] b)
        {
            if (a == null || b == null)
                return false;

            if (a.Length != b.Length)
                return false;

            int result = 0;

            for (int i = 0; i < a.Length; i++)
            {
                result |= a[i] ^ b[i];
            }

            return result == 0;
        }


        // ============================================
        // LOGOUT
        // ============================================

        public static void Logout()
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
        }
    }
}