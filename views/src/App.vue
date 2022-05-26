<template>
  <v-app>
    <v-card
    dark
    tile
  >
    <v-toolbar height="70px" dense>
      <v-toolbar-title><v-btn plain text to="/" color="white"> ICU-Manager</v-btn></v-toolbar-title>

      <v-spacer></v-spacer>
      <v-menu v-if="isAuthenticated" open-on-hover offset-y transition="slide-y-transition" bottom>
        <template v-slot:activator="{ on }">
          <v-btn dark text v-on="on">
            Μενου
          </v-btn>
        </template>
        <v-list>
          <v-list-item to="/">
            <v-icon>mdi-home</v-icon>
            <v-list-item-title>Αρχική</v-list-item-title>
          </v-list-item>
          <v-list-item to="/patients">
            <v-icon>mdi-bed</v-icon>

            <v-list-item-title>Ασθενείς</v-list-item-title>
          </v-list-item>

          <v-list-item to="/worker">
            <v-icon>mdi-shield-account</v-icon>
            <v-list-item-title>Ο λογαριασμός μου</v-list-item-title>
          </v-list-item>
          <v-list-item @click="logout">
            <v-icon>mdi-logout-variant</v-icon>

            <v-list-item-title>Αποσύνδεση</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-toolbar>
    </v-card>
    <v-container class="spacing-playground py-12">
    <router-view> </router-view>
    </v-container>
    <div class="footer">

        {{ new Date().getFullYear() }} — <strong>ICU-Manager</strong>
    </div>
  </v-app>
</template>

<script>

export default {
  name: "App",
  data: () => ({
  }),
  computed: {
    isAuthenticated() {
      return this.$store.getters.isAuthenticated
    }
  },
  methods: {
    async logout() {
      await this.$store.commit('LogOut')
      await this.$router.push('/login')
    },
  },
};
</script>

<style>
.footer {
  position:fixed;
  bottom:0;
  color: azure;
  background-color: #333333;
  display: inline-block;
  text-align: center;
  width: 100%;
  height: 33px;
}
</style>