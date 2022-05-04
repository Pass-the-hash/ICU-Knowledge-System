<template>
  <v-app>
    <v-card
    dark
    tile
  >
    <v-toolbar height="70px" dense v-if="this.navbar">
      <v-toolbar-title><v-btn plain text href="/" color="white"> ICU-Manager</v-btn></v-toolbar-title>

      <v-spacer></v-spacer>
      <v-menu open-on-hover offset-y transition="slide-y-transition" bottom>
        <template v-slot:activator="{ on }">
          <v-btn dark text v-on="on">
<!--            <v-icon> mdi-arrow-down-drop-circle </v-icon>-->
            Μενου
          </v-btn>
        </template>
        <v-list>
          <v-list-item href="/">
            <v-icon>mdi-home</v-icon>
            <v-list-item-title>Αρχική</v-list-item-title>
          </v-list-item>
          <v-list-item href="/patients">
            <v-icon>mdi-bed</v-icon>

            <v-list-item-title>Ασθενείς</v-list-item-title>
          </v-list-item>

          <v-list-item href="/worker">
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
    <router-view> </router-view>
    <div class="footer" v-if="this.footer">

        {{ new Date().getFullYear() }} — <strong>ICU-Manager</strong>
    </div>
  </v-app>
</template>

<script>
import {mapActions} from "vuex"

export default {
  name: "App",
  data: () => ({
    footer: true,
    navbar: true,
  }),
  methods: {
    ...mapActions([
      'fetchAccessToken'
    ]),
    async logout() {
      await this.$store.commit('LogOut')
      await this.$router.push('/login')
    },
     login() {
      return this.$route.path === '/login'
    },
     analysis() {
      return this.$route.name === 'statistics'
    }
  },
  created() {
    this.fetchAccessToken();
  },
  mounted() {
    this.navbar = !this.login()
    this.footer = !this.analysis() && !this.login()

  }
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