<script setup lang="ts">
import { useAuth } from './composables/useAuth'

const { user, loading, loginWithGoogle, logout } = useAuth()
</script>

<template>
  <!-- Full-screen login overlay -->
  <Transition name="fade">
    <div v-if="!loading && !user" class="auth-overlay">
      <div class="login-box">
        <h2>Castalia Institute</h2>
        <p class="subtitle">Where Wisdom Meets Intelligence</p>
        <p class="desc">Sign in with your Google account to view the marketing deck.</p>
        <button class="google-btn" @click="loginWithGoogle">
          <svg viewBox="0 0 24 24" width="20" height="20">
            <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
            <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
            <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
            <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
          </svg>
          Login with Google
        </button>
      </div>
    </div>
  </Transition>

  <!-- Slim header bar when authenticated -->
  <div v-if="user" class="auth-header">
    <span class="brand">Castalia Institute</span>
    <div class="user-section">
      <span class="email">{{ user.email }}</span>
      <button class="logout-btn" @click="logout">Logout</button>
    </div>
  </div>
</template>

<style scoped>
.auth-overlay {
  position: fixed;
  inset: 0;
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.login-box {
  background: white;
  padding: 48px 40px;
  border-radius: 20px;
  text-align: center;
  max-width: 420px;
  width: 90%;
  box-shadow: 0 25px 60px rgba(0, 0, 0, 0.3);
}

.login-box h2 {
  color: #222;
  font-size: 2rem;
  font-weight: 700;
  margin: 0 0 4px;
  font-family: 'Playfair Display', serif;
}

.login-box .subtitle {
  color: #667eea;
  font-style: italic;
  margin: 0 0 20px;
  font-size: 1rem;
}

.login-box .desc {
  color: #666;
  margin: 0 0 28px;
  line-height: 1.6;
  font-size: 0.95rem;
}

.google-btn {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  background: white;
  color: #333;
  border: 1px solid #dadce0;
  padding: 12px 28px;
  border-radius: 8px;
  cursor: pointer;
  font-size: 0.95rem;
  font-weight: 500;
  transition: all 0.2s;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
}

.google-btn:hover {
  background: #f8f9fa;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  transform: translateY(-1px);
}

.auth-header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: 40px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  z-index: 9998;
  font-family: system-ui, sans-serif;
}

.brand {
  color: white;
  font-size: 0.85rem;
  font-weight: 600;
  letter-spacing: 0.02em;
}

.user-section {
  display: flex;
  align-items: center;
  gap: 12px;
}

.email {
  color: rgba(255, 255, 255, 0.85);
  font-size: 0.8rem;
}

.logout-btn {
  background: rgba(255, 255, 255, 0.15);
  border: 1px solid rgba(255, 255, 255, 0.25);
  color: white;
  padding: 4px 14px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 0.78rem;
  transition: background 0.2s;
}

.logout-btn:hover {
  background: rgba(255, 255, 255, 0.25);
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.4s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
