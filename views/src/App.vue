<template>
  <v-app>
    <v-app-bar style="margin-bottom:30px;" color="black" dark>
      <div class="d-flex align-center">
        <v-toolbar-title><v-icon> mdi-hospital-building </v-icon> ICU-Manager</v-toolbar-title>
      </div>

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
          <v-list-item href="/analysis">
            <v-icon>mdi-state-machine</v-icon>

            <v-list-item-title>Analysis</v-list-item-title>
          </v-list-item>
          <v-list-item href="/workers">
            <v-icon>mdi-shield-account</v-icon>

            <v-list-item-title>My Account</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>
      <router-view />
    <v-footer style="margin-top:30px;" padless>
      <v-card flat tile class="black white--text text-center">
        <v-card-text class="white--text pt-0">
          Lorem ipsum dolor sit amet, eum ea hinc eros splendide, te sit volumus
          verterem. Cu intellegat suscipiantur eum, mucius accusamus ne duo. His
          an lorem omnium labores, sanctus feugait quaestio ius ut, sed ad
          maluisset posidonium instructior. Sea nobis facilis ea. Te alienum
          iracundia mei. Sit ut congue tritani molestiae, duo ex tota
          comprehensam, quodsi docendi consetetur no mea. Nostro luptatum
          accommodare vel eu, ne usu dicat signiferumque, cum ei solum labore
          aliquando. Est cu dicit vivendo cotidieque, sonet vituperatoribus eos
          ad. Sed maluisset theophrastus voluptatibus ea. In eum odio graeci
          legimus, ne quo illud noluisse insolens. An tempor antiopam duo. Te
          pro option laoreet. Eam ad adipisci praesent tincidunt, his utamur
          verterem ex. Virtute placerat percipit mel cu. Quo ei offendit
          repudiare, nec ea bonorum maluisset efficiendi. Mei errem alienum
          forensibus ad.
        </v-card-text>

        <v-divider class="grey"></v-divider>

        <v-card-text class="white--text">
          {{ new Date().getFullYear() }} — <strong>ICU-Manager</strong>
        </v-card-text>
      </v-card>
    </v-footer>
  </v-app>
</template>

<script>
export default {
  name: "App",
};
</script>
