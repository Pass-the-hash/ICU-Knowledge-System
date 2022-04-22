<template>
  <v-container
        color="grey darken-2"
    >

    <apexchart width="500" :options="options" ></apexchart>
  </v-container>
</template>

<script>
import axios from "axios";

export default {
  name: "Predictions",
  data: () =>({
    options: {
    },
    series: [],

  }),
  methods: {
    getPredictions() {
      axios
        .post("http://localhost:3000/analysis/" + this.patient.AMKA + "calculate", this.patient)
        .then((response) => (this.response = response));
    },
    updateChart() {

      // const colors = ['#008FFB', '#00E396', '#FEB019', '#FF4560', '#775DD0']

      // Make sure to update the whole options config and not just a single property to allow the Vue watch catch the change.
      /*this.series =  [
          {
            name: 'Πίεση παρεχόμενου οξυγόνου',
            data: this.information.PaO2
          },
          {
            name: 'Ποσοστό παρεχόμενου οξυγόνου',
            data: this.information.FiO2
          },
          {
            name: 'Κρεατινίνη',
            data: this.information.CR
          },
          {
            name: 'Χολυρεθρίνη',
            data: this.information.BIL
          },
          {
            name: 'Αιμοπετάλια',
            data: this.information.PLT
          }
        ]*/

      this.options = {
        series: [70],
        chart: {
          height: 350,
          type: 'radialBar',
        },
        plotOptions: {
          radialBar: {
            hollow: {
              size: '70%',
            }
          },
        },
        labels: ['Cricket'],
      }


      // In the same way, update the series option
    }
  }
}
</script>

<style scoped>

</style>