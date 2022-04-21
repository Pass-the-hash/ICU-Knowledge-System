import Vue from 'vue';
import Vuetify from 'vuetify/lib/framework';
import colors from 'vuetify/lib/util/colors'

Vue.use(Vuetify);

const vuetify = new Vuetify({
    theme: {
        themes: {
            light: {
                primary: colors.purple,
                secondary: colors.grey.darken1,
                accent: colors.shades.black,
                error: colors.red.accent3,
                background: colors.indigo.lighten5, // Not automatically applied
            },
            dark: {
                primary: colors.blue.lighten3,
                background: colors.grey.darken4, // If not using lighten/darken, use base to return hex
                defaultFontColor: colors.white
            },
        },
    },
});

export default vuetify