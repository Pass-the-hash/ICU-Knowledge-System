<template>
  <v-app
    :style="{background: $vuetify.theme.themes['dark'].background}"
  >
   <v-sheet
    color="light green"
    dark
    tile
   >
  <v-navigation-drawer
      v-model="drawer"
      absolute
      bottom
      temporary
      dark
  >
    <v-list
        nav
        dense
    >
      <v-list-item-group
          v-model="group"
          active-class="deep-purple--text text--accent-4"
      >
        <v-list-item>
          <v-list-item-title @click="choice = 'add'">Προσθήκη πληροφοριών</v-list-item-title>
        </v-list-item>

        <v-list-item>
          <v-list-item-title @click="choice = 'stats'">Προβολή στατιστικών</v-list-item-title>
        </v-list-item>

<!--        <v-list-item>
          <v-list-item-title>Buzz</v-list-item-title>
        </v-list-item>
       -->
        <v-list-item>
          <v-list-item-title @click="choice = 'ml'">Προβλέψεις</v-list-item-title>
        </v-list-item>

      </v-list-item-group>
    </v-list>
  </v-navigation-drawer>

<v-toolbar
    color="success"
>
  <v-app-bar-nav-icon  @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

  <v-toolbar-title>Στατιστικά στοιχεία για {{this.patient.name}} {{this.patient.surname}}</v-toolbar-title>
</v-toolbar>

  <!--      <v-spacer></v-spacer>

        <v-btn icon>
          <v-icon>mdi-magnify</v-icon>
        </v-btn>

        <v-btn icon>
          <v-icon>mdi-filter</v-icon>
        </v-btn>

        <v-btn icon>
          <v-icon>mdi-dots-vertical</v-icon>
        </v-btn>-->


</v-sheet>

    <v-container
        min-width="100%"
        dark
    >

      <v-container>
        <Add information="information" :headers=this.headers v-if="choice === 'add'"></Add>
      </v-container>

      <v-container v-if="choice === 'stats'">
        <Statistics :patient=this.patient :information=this.information></Statistics>
      </v-container>


      <div class="main" v-if="this.information.BIL.length === 0 && choice === false">
        <h1> Ο ασθενής νοσηλεύεται, αλλά δεν έχουν εισαχθεί δεδομένα. </h1>
        <br>

      </div>
      <div class="button" v-if="this.information.BIL.length === 0 && choice === false">
        <v-btn
            text
            dark
            x-large
            plain
            @click="callAdd"
        >
          Προσθηκη δεδομενων
        </v-btn>
      </div>

<!--        <h1>
        <v-btn icon target="_blank" dark @click="choice === 'add'">
          <v-icon>window</v-icon> Προσθήκη δεδομένων
        </v-btn>
        </h1>-->

<!--      <v-toolbar
          dark
      >
        <v-toolbar-title>

        </v-toolbar-title>
      </v-toolbar>-->
      <v-container v-if="choice === 'ml'" class="text-center">
<!--        <h2> Μας συγχωρείτε, αλλά η δυνατότητα δεν είναι ακόμα διαθέσιμη! 😷</h2>
        <Construction></Construction>-->
        <Predictions :patient="this.patient" :headers="this.headers" ></Predictions>
      </v-container>
    </v-container>

</v-app>
</template>

<script>
import axios from "axios"
import Statistics from "@/components/Statistics";
import Add from "@/components/Add";
// import Construction from "@/views/Construction";
import Predictions from "@/components/Predictions";

export default {
  name: "General",
  data: () => ({
    footer: false,
    network: null,
    response: null,
    chart: null,
    patients: [],
    expanded: [],
    singleExpand: false,
    patient: null,
    information: null,
    choice: false,
    drawer: false,
    group: null,
    msg: null,
    headers: {},
    token: null,
  }),
  components: {
    Predictions,
    // Construction,
    Add,
    Statistics,
  },
  methods: {
    callAdd(){
      this.choice = 'add'
    },
     get() {
       axios
          .get("http://localhost:3000/analysis/" + this.$route.params.AMKA, this.headers)
          .then((response) => (this.information = response.data))

       axios
          .get("http://localhost:3000/patients/" + this.$route.params.AMKA, this.headers)
          .then((response) => (this.patient = response.data));
      // this.updateChart()
    },
    /*update() {
      axios
        .patch("http://localhost:3000/analysis/25006", )
        .then((response) => (this.information = response.data));
    },*/
    getUserDetails() {
      // get token from localstorage
      this.token = localStorage.getItem("accessToken");
      // console.log(this.token)
      this.headers = {
        headers:{
          'Authorization': `Basic ${this.token}`
        }
      }
    }
  },
  created() {
    this.getUserDetails()
  },
  mounted() {
    console.log(this.headers)
    this.get()
  },

}
</script>

<style scoped>
h1, h2 {
  color: azure;
}
.main {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 50vh;
}
.button {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 10vh;
}

</style>