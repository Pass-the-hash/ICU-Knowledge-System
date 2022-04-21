<template>
  <v-app>
    <v-card
    dark
    tile
  >
    <v-toolbar height="70px" dense>
      <v-toolbar-title><v-btn plain text href="/" color="white"> ICU-Manager</v-btn></v-toolbar-title>

      <v-spacer></v-spacer>
      <v-menu offset-y>
        <template v-slot:activator="{ on }">
          <v-btn color="success" dark v-on="on">
            <v-icon> mdi-arrow-down-drop-circle </v-icon>
            Actions
          </v-btn>
        </template>
        <v-list>
          <v-list-item href="/">
            <v-icon>mdi-home</v-icon>
            <v-list-item-title>Home</v-list-item-title>
          </v-list-item>
          <v-list-item href="/patients">
            <v-icon>mdi-bed</v-icon>

            <v-list-item-title>Patients</v-list-item-title>
          </v-list-item>
          <v-list-item href="/construct">
            <v-icon>mdi-state-machine</v-icon>

            <v-list-item-title>Analysis</v-list-item-title>
          </v-list-item>
          <v-list-item href="/workers">
            <v-icon>mdi-shield-account</v-icon>

            <v-list-item-title>My Account</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-toolbar>
    </v-card>
      <router-view> </router-view>
    <div class="footer" >

        {{ new Date().getFullYear() }} — <strong>ICU-Manager</strong>
    </div>
  </v-app>
</template>

<script>
export default {
  name: "App",
  /*data: () => ({
    footer: true
  })*/
};
</script>

<style>
.footer {
  visibility: hidden;
  position: fixed;
  left: 0;
  bottom: 0;
  width: 100%;
  background-color: #333333;
  color: white;
  text-align: center;
  height: 50px;
}
</style>